import 'dart:async';
import 'dart:typed_data';
import 'package:epub_plus/epub_plus.dart' hide Image;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../../../core/services/HtmlService.dart';

class EpubVirtualChapterView extends StatefulWidget {
  final List<String>? chunks;
  final EpubChapterRef? chapterRef;
  final int initialItemIndex;
  final Future<Uint8List?> Function(String) onLoadImage;
  final Function(int) onScrollIndexChanged;
  final Function(List<String>) onLoadComplete;

  const EpubVirtualChapterView({
    super.key,
    this.chunks,
    this.chapterRef,
    required this.initialItemIndex,
    required this.onLoadImage,
    required this.onScrollIndexChanged,
    required this.onLoadComplete,
  });

  @override
  State<EpubVirtualChapterView> createState() => _EpubVirtualChapterViewState();
}

class _EpubVirtualChapterViewState extends State<EpubVirtualChapterView> with AutomaticKeepAliveClientMixin {
  bool _isLoadingLocal = false;
  static const _baseTextStyle = TextStyle(fontSize: 18, height: 1.6, color: Colors.black87);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    if (widget.chunks == null && widget.chapterRef != null) {
      _loadAndSplitLocal();
    }
  }

  Future<void> _loadAndSplitLocal() async {
    setState(() => _isLoadingLocal = true);
    try {
      final html = await widget.chapterRef!.readHtmlContent();
      final chunks = await compute(parseHtmlInIsolate, html);
      widget.onLoadComplete(chunks);
      if (mounted) setState(() => _isLoadingLocal = false);
    } catch (e) {
      if (mounted) setState(() => _isLoadingLocal = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (_isLoadingLocal && widget.chunks == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final data = widget.chunks ?? [];
    if (data.isEmpty) return const SizedBox();

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: ListView.separated(
        itemCount: data.length,
        cacheExtent: 800,
        controller: ScrollController(initialScrollOffset: widget.initialItemIndex * 100.0),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        separatorBuilder: (c, i) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          if (index % 10 == 0) {
            Future.microtask(() => widget.onScrollIndexChanged(index));
          }

          return HtmlWidget(
            data[index],
            textStyle: _baseTextStyle,
            renderMode: RenderMode.column,
            enableCaching: true,
            onTapUrl: (_) async => true,
            customWidgetBuilder: (element) {
              if (element.localName == 'img') {
                final src = element.attributes['src'];
                if (src != null) {
                  return _buildCachedImage(src);
                }
              }
              return null;
            },
          );
        },
      ),
    );
  }

  Widget _buildCachedImage(String src) {
    final cleanName = src.split('/').last;

    return FutureBuilder<Uint8List?>(
      future: widget.onLoadImage(cleanName),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return RepaintBoundary(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 500),
              child: Image.memory(
                snapshot.data!,
                fit: BoxFit.contain,
                gaplessPlayback: true,
              ),
            ),
          );
        }
        return const SizedBox(height: 20);
      },
    );
  }
}