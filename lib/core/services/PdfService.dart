import 'dart:io';
import 'package:pdfx/pdfx.dart';
import 'package:path/path.dart' as p;

import '../constants/StorageConstants.dart';

class PdfProcessingResult {
  final int pageCount;
  final String coverImagePath;

  const PdfProcessingResult({
    required this.pageCount,
    required this.coverImagePath,
  });
}

class PdfHelper {

  static Future<PdfProcessingResult> processPdf(String filePath, String uniqueId, Directory rootDir) async {
    try {
      final document = await PdfDocument.openFile(filePath);
      final int pageCount = document.pagesCount;
      final page = await document.getPage(1);
      final pageImage = await page.render(
        width: page.width * 2,
        height: page.height * 2,
        format: PdfPageImageFormat.jpeg,
        quality: 80,
      );
      await page.close();
      await document.close();

      if (pageImage == null) {
        throw Exception("Failed to render cover image");
      }

      final String targetFolderPath = p.join(rootDir.path, appFolderName, coversFolderName);
      final targetDirectory = Directory(targetFolderPath);
      if (!await targetDirectory.exists()) {
        await targetDirectory.create(recursive: true);
      }
      final String coverPath = p.join(targetFolderPath, 'cover_$uniqueId.png');

      final imageFile = File(coverPath);
      await imageFile.writeAsBytes(pageImage.bytes);

      return PdfProcessingResult(
          pageCount: pageCount,
          coverImagePath: coverPath
      );
    } catch (e) {
      throw Exception("Error processing PDF: $e");
    }
  }

  static Future<String> saveBookFile(String sourcePath, String uniqueId, Directory rootDir) async {
    try {
      final String targetFolderPath = p.join(rootDir.path, appFolderName, booksFolderName);
      final targetDirectory = Directory(targetFolderPath);

      if (!await targetDirectory.exists()) {
        await targetDirectory.create(recursive: true);
      }

      final String newPath = p.join(targetFolderPath, 'book_$uniqueId.pdf');

      final sourceFile = File(sourcePath);
      await sourceFile.copy(newPath);

      return newPath;
    } catch (e) {
      throw Exception("Failed to save book file: $e");
    }
  }

}