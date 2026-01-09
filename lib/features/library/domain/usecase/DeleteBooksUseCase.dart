import 'package:injectable/injectable.dart';

import '../../../../core/base/DataClass.dart';
import '../../../../core/services/FileService.dart';
import '../repository/LibraryRepository.dart';

@lazySingleton
class DeleteBooksUseCase {
  final LibraryRepository _libraryRepository;
  DeleteBooksUseCase(this._libraryRepository);

  Future<bool> call(Set<int> ids) async {
    try {
      final databaseDeletionResult = await _libraryRepository.deleteBooks(ids);

      if (databaseDeletionResult is DataSuccess && databaseDeletionResult.data != null) {
        final deletedBooks = databaseDeletionResult.data!;
        final List<String> pathsToDelete = [];
        for (var book in deletedBooks) {
          pathsToDelete.add(book.path);
          pathsToDelete.add(book.coverPath);
        }
        await FileHelper.deleteFiles(pathsToDelete);
      }

      return true;
    } catch (e) {
      return false;
    }
  }
}