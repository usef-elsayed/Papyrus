import 'package:Papyrus/core/base/DataClass.dart';

abstract class ReaderRepository {
  Future<DataState<bool>> updateBookProgress(int bookId, int newPage, String? currentCfi);
}