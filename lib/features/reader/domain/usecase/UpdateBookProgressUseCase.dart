import 'package:injectable/injectable.dart';

import '../../../../core/base/DataClass.dart';
import '../repository/ReaderRepository.dart';

@lazySingleton
class UpdateBookProgressUseCase {
  final ReaderRepository _readerRepository;

  UpdateBookProgressUseCase(this._readerRepository);

  Future<DataState<bool>> call(int bookId, int newPage, String? currentCfi) async {
    return await _readerRepository.updateBookProgress(bookId, newPage, currentCfi);
  }
}