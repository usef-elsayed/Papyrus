import 'package:Papyrus/features/activity/domain/usecase/GetLastAccessedBooksUseCase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/base/DataClass.dart';
import '../../../library/domain/entity/BookEntity.dart';

part 'ActivityState.dart';

@injectable
class ActivityCubit extends Cubit<ActivityState> {

  final GetLastAccessedBooksUseCase _getLastAccessedBooksUseCase;
  ActivityCubit(this._getLastAccessedBooksUseCase): super(ActivityLoading());

  void loadLastAccessedBooks() async {
    final result = await _getLastAccessedBooksUseCase.call();
    if (result is DataSuccess && result.data != null && result.data?.isNotEmpty == true) {
      emit(ActivityLoaded(result.data!));
    }else if (result is DataSuccess && (result.data == null || result.data?.isEmpty == true)) {
      emit(ActivityNoBooks());
    }else {
      emit(ActivityError());
    }
  }

}