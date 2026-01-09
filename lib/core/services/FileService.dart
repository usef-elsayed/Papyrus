import 'dart:io';
import 'dart:developer';

import 'package:injectable/injectable.dart';

@lazySingleton
class FileHelper {

  static Future<void> deleteFiles(List<String?> paths) async {
    for (final path in paths) {
      if (path == null || path.isEmpty) continue;

      try {
        final file = File(path);
        if (await file.exists()) {
          await file.delete();
          log('Deleted file: $path', name: 'FileHelper');
        } else {
          log('File not found (skipped): $path', name: 'FileHelper');
        }
      } catch (e) {
        log('Failed to delete file at $path: $e', name: 'FileHelper');
      }
    }
  }
}