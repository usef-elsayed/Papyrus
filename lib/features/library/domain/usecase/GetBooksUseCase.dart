import 'package:injectable/injectable.dart';

import '../../../../core/base/DataClass.dart';
import '../entity/BookEntity.dart';
import '../repository/LibraryRepository.dart';

@lazySingleton
class GetBooksUseCase {

  final LibraryRepository _libraryRepository;

  GetBooksUseCase(this._libraryRepository);

  Future<DataState<List<BookEntity>>> call() async {
    return await _libraryRepository.getBooks();
  }

}