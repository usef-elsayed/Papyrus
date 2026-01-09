import 'package:Papyrus/core/base/DataClass.dart';
import 'package:Papyrus/features/library/domain/entity/BookEntity.dart';
import 'package:injectable/injectable.dart';

import '../repository/ActivityRepository.dart';

@lazySingleton
class GetLastAccessedBooksUseCase {
  final ActivityRepository _activityRepository;

  GetLastAccessedBooksUseCase(this._activityRepository);

  Future<DataState<List<BookEntity>>> call() async {
    return await _activityRepository.getLastAccessedBooks();
  }
}