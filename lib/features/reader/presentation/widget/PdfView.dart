import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfViewWidget extends StatefulWidget {
  final String path;
  final int initialPage;
  final void Function(int currentPage) onUpdateProgress;

  const PdfViewWidget({
    super.key,
    required this.path,
    required this.initialPage,
    required this.onUpdateProgress,
  });

  @override
  State<PdfViewWidget> createState() => _PdfViewWidgetState();
}

class _PdfViewWidgetState extends State<PdfViewWidget> {
  late final PdfController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PdfController(
      document: PdfDocument.openFile(widget.path),
      initialPage: widget.initialPage,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;
    return PdfView(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      pageSnapping: true,
      backgroundDecoration: BoxDecoration(color: Colors.grey[100]),
      renderer: (PdfPage page) async {
        final image = await page.render(
          width: page.width * (pixelRatio * 1.3),
          height: page.height * (pixelRatio * 1.3),
          format: PdfPageImageFormat.jpeg,
          quality: 100,
        );
        return image;
      },
      builders: PdfViewBuilders<DefaultBuilderOptions>(
        options: const DefaultBuilderOptions(),
        documentLoaderBuilder: (_) =>
        const Center(child: CircularProgressIndicator()),
        pageLoaderBuilder: (_) =>
        const Center(child: CircularProgressIndicator()),
        errorBuilder: (_, error) =>
            Center(child: Text('Error: $error')),
      ),
      onPageChanged: (page) {
        widget.onUpdateProgress(page);
      },
    );
  }
}
