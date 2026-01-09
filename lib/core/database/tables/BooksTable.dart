import 'package:drift/drift.dart';

enum BookStatus {
  read,
  inProgress,
  unread
}

class BooksTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get path => text()();
  TextColumn get title => text()();
  TextColumn get coverPath => text()();
  IntColumn get totalPages => integer()();
  IntColumn get currentPage => integer().withDefault(const Constant(0))();
  IntColumn get status => intEnum<BookStatus>().withDefault(Constant(BookStatus.unread.index))();
  DateTimeColumn get lastAccess => dateTime().nullable()();
  TextColumn get bookCfi => text().nullable()();
}