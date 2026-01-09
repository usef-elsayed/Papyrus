part of 'LibraryBloc.dart';

class LibraryState extends Equatable {
  const LibraryState();

  @override
  List<Object?> get props => [];
}

class LibraryLoading extends LibraryState {
  const LibraryLoading();
}

class LibraryLoaded extends LibraryState {
  final List<BookEntity> listOfBooks;
  final Set<int> selectedIds;
  const LibraryLoaded(this.listOfBooks, this.selectedIds);
  bool get isSelectionMode => selectedIds.isNotEmpty;

  @override
  List<Object?> get props => [listOfBooks, selectedIds];

  LibraryLoaded copyWith({ List<BookEntity>? listOfBooks, Set<int>? selectedIds }) {
    return LibraryLoaded(
      listOfBooks ?? this.listOfBooks,
      selectedIds ?? this.selectedIds,
    );
  }
}

class LibraryError extends LibraryState {
  final String error;
  const LibraryError(this.error);
  @override
  List<Object?> get props => [error];
}

class LibraryNoBooks extends LibraryState {
  const LibraryNoBooks();
}