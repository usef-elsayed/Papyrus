import 'package:Papyrus/features/library/domain/entity/BookEntity.dart';

import '../../../../core/base/DataClass.dart';

abstract class LibraryRepository {
  Future<bool> addBook(BookEntity book);
  Future<DataState<List<BookEntity>>> getBooks();
  Future<DataState<List<BookEntity>>> deleteBooks(Set<int> ids);
}