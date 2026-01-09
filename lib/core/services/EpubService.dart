import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:epub_plus/epub_plus.dart';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import '../constants/StorageConstants.dart';

class EpubProcessingResult {
  final int pageCount;
  final String coverImagePath;

  const EpubProcessingResult({
    required this.pageCount,
    required this.coverImagePath,
  });
}

class _IsolateArgs {
  final String filePath;
  final String uniqueId;
  final String savePath;
  _IsolateArgs({
    required this.filePath,
    required this.uniqueId,
    required this.savePath,
  });
}

class EpubHelper {

  static Future<EpubProcessingResult> processEpub(String filePath, String uniqueId, Directory rootDir) async {
    final String targetFolderPath = p.join(rootDir.path, appFolderName, coversFolderName);
    final targetDirectory = Directory(targetFolderPath);

    if (!await targetDirectory.exists()) {
      await targetDirectory.create(recursive: true);
    }

    final String coverSavePath = p.join(targetFolderPath, 'cover_$uniqueId.jpg');

    return await compute(_processBookInIsolate, _IsolateArgs(
      filePath: filePath,
      uniqueId: uniqueId,
      savePath: coverSavePath,
    ));
  }

  static Future<String> saveBookFile(String sourcePath, String uniqueId, Directory rootDir) async {
    try {
      final String targetFolderPath = p.join(rootDir.path, appFolderName, booksFolderName);
      final targetDirectory = Directory(targetFolderPath);

      if (!await targetDirectory.exists()) {
        await targetDirectory.create(recursive: true);
      }

      final String newPath = p.join(targetFolderPath, 'book_$uniqueId.epub');
      final sourceFile = File(sourcePath);
      await sourceFile.copy(newPath);

      return newPath;
    } catch (e) {
      throw Exception("Failed to save book file: $e");
    }
  }
}

Future<EpubProcessingResult> _processBookInIsolate(_IsolateArgs args) async {
  try {
    final file = File(args.filePath);
    final List<int> bytes = await file.readAsBytes();

    final EpubBook epubBook = await EpubReader.readBook(bytes);

    int totalCharacters = 0;
    for (var chapter in epubBook.chapters) {
      totalCharacters += _countCharactersRecursive(chapter);
    }

    final int estimatedPageCount = (totalCharacters / 750).ceil().clamp(1, 99999);

    img.Image? coverImage = epubBook.coverImage;

    if (coverImage == null) {
      final images = epubBook.content?.images;
      if (images != null && images.isNotEmpty) {

        final largestImageEntry = images.values.reduce((curr, next) {
          final currSize = curr.content?.length ?? 0;
          final nextSize = next.content?.length ?? 0;
          return currSize > nextSize ? curr : next;
        });

        if (largestImageEntry.content != null) {
          final Uint8List imageBytes = Uint8List.fromList(largestImageEntry.content!);
          coverImage = img.decodeImage(imageBytes);
        }
      }
    }

    if (coverImage == null) {
      coverImage = img.Image(width: 300, height: 450);
      img.fill(coverImage, color: img.ColorRgb8(60, 70, 90));
    }

    final List<int> jpegBytes = img.encodeJpg(coverImage!, quality: 80);

    final imageFile = File(args.savePath);
    await imageFile.writeAsBytes(jpegBytes);

    return EpubProcessingResult(
      pageCount: estimatedPageCount,
      coverImagePath: args.savePath,
    );

  } catch (e) {
    throw Exception("Background processing failed: $e");
  }
}
int _countCharactersRecursive(EpubChapter chapter) {
  int count = chapter.htmlContent?.length ?? 0;
  for (var subChapter in chapter.subChapters) {
    count += _countCharactersRecursive(subChapter);
  }
  return count;
}