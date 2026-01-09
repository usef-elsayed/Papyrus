import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:epub_plus/epub_plus.dart' hide Image;
import '../../../../core/services/HtmlService.dart';
import 'EpubVirtualChapterView.dart';

class EpubViewWidget extends StatefulWidget {
  final String path;
  final String? initialCfi;
  final int totalPages;
  final Function(int page, String cfi) onUpdateProgress;

  const EpubViewWidget({
    super.key,
    required this.path,
    required this.totalPages,
    required this.onUpdateProgress,
    this.initialCfi,
  });

  @override
  State<EpubViewWidget> createState() => _EpubViewWidgetState();
}

class _EpubViewWidgetState extends State<EpubViewWidget> {
  List<EpubChapterRef> _chapters = [];
  bool _isLoading = true;

  final Map<int, List<String>> _chapterChunksCache = {};
  final Map<String, Uint8List> _imageCache = {};
  Map<String, dynamic> _imageRefMap = {};

  late PageController _pageController;
  int _currentChapterIndex = 0;
  int _initialChapterIndex = 0;
  int _initialParagraphIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadBookRef();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _imageCache.clear();
    super.dispose();
  }

  Future<void> _loadBookRef() async {
    try {
      final file = File(widget.path);
      final bytes = await file.readAsBytes();
      final bookRef = await EpubReader.openBook(bytes);
      final List<EpubChapterRef> chapterList = bookRef.getChapters();

      final Map<String, dynamic> tempImageRefMap = {};
      if (bookRef.content?.images != null) {
        bookRef.content!.images.forEach((key, value) {
          final filename = key.split('/').last;
          tempImageRefMap[filename] = value;
        });
      }

      if (widget.initialCfi != null && widget.initialCfi!.contains('/')) {
        final parts = widget.initialCfi!.split('/');
        _initialChapterIndex = int.tryParse(parts[0]) ?? 0;
        if (parts.length > 1) {
          _initialParagraphIndex = int.tryParse(parts[1])?.floor() ?? 0;
        }
      }

      if (_initialChapterIndex >= chapterList.length) _initialChapterIndex = 0;

      if (mounted) {
        setState(() {
          _chapters = chapterList;
          _imageRefMap = tempImageRefMap;
          _currentChapterIndex = _initialChapterIndex;
          _isLoading = false;
          _pageController = PageController(initialPage: _initialChapterIndex);
        });
        _processChapter(_initialChapterIndex);
      }
    } catch (e) {
      debugPrint("Error opening EPUB: $e");
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _processChapter(int index) async {
    if (index < 0 || index >= _chapters.length) return;
    if (_chapterChunksCache.containsKey(index)) return;

    try {
      final rawHtml = await _chapters[index].readHtmlContent();
      final chunks = await compute(parseHtmlInIsolate, rawHtml);

      if (mounted) {
        setState(() {
          _chapterChunksCache[index] = chunks;
          _chapterChunksCache.removeWhere((key, _) => (key - index).abs() > 1);
        });
      }
    } catch (e) {
      debugPrint("Error processing chapter $index: $e");
    }
  }

  void _reportProgress(int chapterIndex, int paragraphIndex) {
    final String customCfi = "$chapterIndex/$paragraphIndex";
    final double progressPercent = chapterIndex / (_chapters.isNotEmpty ? _chapters.length : 1);
    final int calculatedPage = (progressPercent * widget.totalPages).ceil().clamp(1, widget.totalPages);
    widget.onUpdateProgress(calculatedPage, customCfi);
  }

  Future<Uint8List?> _loadImageBytes(String filename) async {
    if (_imageCache.containsKey(filename)) {
      return _imageCache[filename];
    }

    final dynamic imageRef = _imageRefMap[filename];
    if (imageRef == null) return null;

    try {
      final List<int> content = await (imageRef as dynamic).readContent();
      final bytes = Uint8List.fromList(content);

      _imageCache[filename] = bytes;
      return bytes;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    if (_chapters.isEmpty) return const Center(child: Text("Failed to load book"));

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: PageView.builder(
          controller: _pageController,
          itemCount: _chapters.length,
          allowImplicitScrolling: true,
          physics: const ClampingScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _currentChapterIndex = index;
            });
            _processChapter(index);
            _processChapter(index + 1);
            _reportProgress(index, 0);
          },
          itemBuilder: (context, index) {
            final chunks = _chapterChunksCache[index];
            return EpubVirtualChapterView(
              chunks: chunks,
              chapterRef: chunks == null ? _chapters[index] : null,
              initialItemIndex: (index == _initialChapterIndex) ? _initialParagraphIndex : 0,
              onLoadImage: _loadImageBytes,
              onScrollIndexChanged: (itemIndex) {
                if (index == _currentChapterIndex) {
                  _reportProgress(index, itemIndex);
                }
              },
              onLoadComplete: (loadedChunks) {
                if (!_chapterChunksCache.containsKey(index)) {
                  _chapterChunksCache[index] = loadedChunks;
                }
              },
            );
          },
        ),
      ),
    );
  }
}
