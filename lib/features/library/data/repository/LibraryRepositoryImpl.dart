import 'package:Papyrus/core/base/DataClass.dart';
import 'package:Papyrus/features/library/data/model/BookModel.dart';
import 'package:Papyrus/features/library/domain/entity/BookEntity.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/database/database/AppDatabase.dart';
import '../../../../core/errors/Failures.dart';
import '../../domain/repository/LibraryRepository.dart';

@LazySingleton(as: LibraryRepository)
class LibraryRepositoryImpl implements LibraryRepository {

  final AppDatabase _db;

  LibraryRepositoryImpl(this._db);

  @override
  Future<bool> addBook(BookEntity book) async {
    try {
      await _db.into(_db.booksTable).insert(BooksTableCompanion.insert(
          path: book.path, title: book.title, coverPath: book.coverPath, totalPages: book.totalPages
      ));
      return true;
    }catch (e){
      return false;
    }
  }

  @override
  Future<DataState<List<BookEntity>>> getBooks() async {
    try {
      final dbResults = await _db.select(_db.booksTable).get();
      final list = dbResults.map((element) => BookModel.fromDb(element)).toList();
      return DataSuccess(list);
    } catch (e){
      return DataFailed(DatabaseFailure());
    }
  }

  @override
  Future<DataState<List<BookEntity>>> deleteBooks(Set<int> ids) async {
    return _db.transaction(() async {
      try {
        final booksToDelete = await (_db.select(_db.booksTable)
          ..where((tbl) => tbl.id.isIn(ids))
        ).get();

        await (_db.delete(_db.booksTable)
          ..where((tbl) => tbl.id.isIn(ids))
        ).go();

        final booksList = booksToDelete.map((element) => BookModel.fromDb(element)).toList();
        return DataSuccess(booksList);
      } catch (e) {
        return DataFailed(DatabaseFailure());
      }
    });
  }



}