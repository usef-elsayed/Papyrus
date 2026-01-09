import 'package:flutter_bloc/flutter_bloc.dart';

enum HomeTab { activity, library }

class HomeLayoutCubit extends Cubit<HomeTab> {

  HomeLayoutCubit() : super(HomeTab.activity);

  void switchToActivity() => emit(HomeTab.activity);
  void switchToLibrary() => emit(HomeTab.library);

}