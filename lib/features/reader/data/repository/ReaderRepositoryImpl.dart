import 'package:Papyrus/core/database/database/AppDatabase.dart';
import 'package:Papyrus/core/base/DataClass.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/Failures.dart';
import '../../domain/repository/ReaderRepository.dart';

@LazySingleton(as: ReaderRepository)
class ReaderRepositoryImpl implements ReaderRepository {

  final AppDatabase _db;
  const ReaderRepositoryImpl(this._db);

  @override
  Future<DataState<bool>> updateBookProgress(int bookId, int newPage, String? currentCfi) async {
    try {
      final statement = _db.update(_db.booksTable)
        ..where((tbl) => tbl.id.equals(bookId));

      final rowsAffected = await statement.write(
        BooksTableCompanion(
          currentPage: Value(newPage),
          lastAccess: Value(DateTime.now()),
          bookCfi: Value(currentCfi)
        ),
      );

      if(rowsAffected > 0) {
        return DataSuccess(true);
      }
      return DataFailed(DatabaseFailure());
    }catch (e) {
      return DataFailed(DatabaseFailure());
    }
  }

}