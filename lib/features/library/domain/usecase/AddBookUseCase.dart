import 'package:Papyrus/core/base/DataClass.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;
import '../../../../core/database/tables/BooksTable.dart';
import '../../../../core/services/EpubService.dart';
import '../../../../core/errors/Failures.dart';
import '../../../../core/services/PdfService.dart';
import '../entity/BookEntity.dart';
import '../repository/LibraryRepository.dart';

@lazySingleton
class AddBookUseCase {

  final LibraryRepository _libraryRepository;

  AddBookUseCase(this._libraryRepository);

  Future<DataState<bool>> call(AddBookParams params) async {
    try {
      final uniqueId = const Uuid().v4();
      final appDir = await getApplicationDocumentsDirectory();
      final extension = p.extension(params.path).toLowerCase();

      String savedBookPath;
      String coverPath;
      int pageCount;

      if (extension == '.pdf') {
        final result = await PdfHelper.processPdf(params.path, uniqueId, appDir);
        savedBookPath = await PdfHelper.saveBookFile(params.path, uniqueId, appDir);
        coverPath = result.coverImagePath;
        pageCount = result.pageCount;

      } else if (extension == '.epub') {
        final result = await EpubHelper.processEpub(params.path, uniqueId, appDir);
        savedBookPath = await EpubHelper.saveBookFile(params.path, uniqueId, appDir);
        coverPath = result.coverImagePath;
        pageCount = result.pageCount;

      } else {
        return DataFailed(BookUndefinedFailure());
      }

      final newBook = BookEntity(
        id: -1,
        path: savedBookPath,
        title: params.title,
        coverPath: coverPath,
        totalPages: pageCount,
        currentPage: 0,
        lastAccess: DateTime.now(),
        status: BookStatus.unread,
        bookCfi: null,
      );

      await _libraryRepository.addBook(newBook);

      return const DataSuccess(true);

    } catch (e) {
      return DataFailed(BookProcessingFailure());
    }
  }
}

class AddBookParams {
  final String path;
  final String title;

  const AddBookParams({required this.path, required this.title});
}