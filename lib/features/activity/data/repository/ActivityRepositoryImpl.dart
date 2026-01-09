import 'package:Papyrus/core/base/DataClass.dart';
import 'package:Papyrus/core/errors/Failures.dart';
import 'package:Papyrus/features/library/data/model/BookModel.dart';
import 'package:Papyrus/features/library/domain/entity/BookEntity.dart';
import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/database/database/AppDatabase.dart';
import '../../domain/repository/ActivityRepository.dart';

@LazySingleton(as: ActivityRepository)
class ActivityRepositoryImpl implements ActivityRepository {

  final AppDatabase _db;
  ActivityRepositoryImpl(this._db);

  @override
  Future<DataState<List<BookEntity>>> getLastAccessedBooks() async {
    try {
      final dbQuery = _db.select(_db.booksTable)
        ..where((tbl) => tbl.currentPage.isBiggerThanValue(0))
        ..orderBy([(t) => OrderingTerm.desc(t.lastAccess)])
        ..limit(5);
      final dbResult = await dbQuery.get();
      return DataSuccess(dbResult.map((element) => BookModel.fromDb(element)).toList());
    }catch (e) {
      return DataFailed(DatabaseFailure());
    }
  }

}