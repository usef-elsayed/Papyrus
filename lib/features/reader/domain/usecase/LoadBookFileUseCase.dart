import 'dart:io';

import 'package:Papyrus/core/base/DataClass.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/Failures.dart';

@lazySingleton
class LoadBookFileUseCase {
  Future<DataState<String>> call(String filePath) async {
    final file = File(filePath);

    if (await file.exists()){
      return DataSuccess(filePath);
    } else {
      return DataFailed(BookProcessingFailure());
    }
  }
}