part of 'LibraryBloc.dart';

class LibraryEvent extends Equatable {
  const LibraryEvent();

  @override
  List<Object?> get props => [];
}

class LibraryLoadBooks extends LibraryEvent {
  const LibraryLoadBooks();
}

class LibraryAddBook extends LibraryEvent {
  final String filePath;
  final String title;

  const LibraryAddBook({required this.filePath, required this.title});

  @override
  List<Object?> get props => [filePath, title];
}

class LibraryToggleSelection extends LibraryEvent {
  final int bookId;
  const LibraryToggleSelection(this.bookId);
}

class LibraryClearSelection extends LibraryEvent {}

class LibraryDeleteSelected extends LibraryEvent {}

class LibrarySortBooks extends LibraryEvent {
  final SortOption sortOption;
  const LibrarySortBooks(this.sortOption);
}
