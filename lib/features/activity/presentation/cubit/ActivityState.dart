part of 'ActivityCubit.dart';

class ActivityState extends Equatable {
  const ActivityState();
  @override
  List<Object?> get props => [];
}

class ActivityLoading extends ActivityState {
  const ActivityLoading();
}

class ActivityNoBooks extends ActivityState {
  const ActivityNoBooks();
}

class ActivityLoaded extends ActivityState {
  final List<BookEntity> listOfBooks;
  const ActivityLoaded(this.listOfBooks);
  @override
  List<Object?> get props => [listOfBooks];
}

class ActivityError extends ActivityState {
  const ActivityError();
}