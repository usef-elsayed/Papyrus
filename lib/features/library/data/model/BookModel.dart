import 'package:Papyrus/core/database/database/AppDatabase.dart';
import 'package:Papyrus/features/library/domain/entity/BookEntity.dart';

class BookModel extends BookEntity {

  const BookModel({
    required super.id,
    required super.path,
    required super.title,
    required super.coverPath,
    required super.currentPage,
    required super.totalPages,
    required super.status,
    super.lastAccess,
    super.bookCfi
  });

  factory BookModel.fromDb(BooksTableData data) {
    return BookModel(
        id: data.id, title: data.title, path: data.path,
        coverPath: data.coverPath, totalPages: data.totalPages,
        status: data.status, currentPage: data.currentPage,
        lastAccess: data.lastAccess, bookCfi: data.bookCfi
    );
  }

}