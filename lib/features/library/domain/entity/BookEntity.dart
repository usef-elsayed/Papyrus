import 'package:Papyrus/core/database/tables/BooksTable.dart';

class BookEntity {
  final int id;
  final String path;
  final String title;
  final String coverPath;
  final int totalPages;
  final int currentPage;
  final BookStatus status;
  final DateTime? lastAccess;
  final String? bookCfi;

  const BookEntity({
    required this.id, required this.path, required this.title,
    required this.coverPath, required this.totalPages, required this.currentPage,
    required this.lastAccess, required this.status, required this.bookCfi
  });

}