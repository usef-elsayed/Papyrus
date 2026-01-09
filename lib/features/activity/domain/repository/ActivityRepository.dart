import 'package:Papyrus/core/base/DataClass.dart';
import 'package:Papyrus/features/library/domain/entity/BookEntity.dart';

abstract class ActivityRepository {
  Future<DataState<List<BookEntity>>> getLastAccessedBooks();
}