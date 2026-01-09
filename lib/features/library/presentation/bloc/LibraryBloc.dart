import 'package:Papyrus/core/base/DataClass.dart';
import 'package:Papyrus/features/library/domain/entity/BookEntity.dart';
import 'package:Papyrus/features/library/domain/usecase/AddBookUseCase.dart';
import 'package:Papyrus/features/library/domain/usecase/GetBooksUseCase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/enums/SortOption.dart';
import '../../domain/usecase/DeleteBooksUseCase.dart';

part 'LibraryState.dart';
part 'LibraryEvent.dart';

@injectable
class LibraryBloc extends Bloc<LibraryEvent, LibraryState> {

  final GetBooksUseCase _getBooksUseCase;
  final AddBookUseCase _addBookUseCase;
  final DeleteBooksUseCase _deleteBooksUseCase;

  LibraryBloc(this._getBooksUseCase, this._addBookUseCase, this._deleteBooksUseCase) : super(LibraryLoading()) {
    on<LibraryLoadBooks> (_loadBooks);
    on<LibraryAddBook> (_addBook);
    on<LibraryToggleSelection> (_toggleSelection);
    on<LibraryClearSelection> (_clearSelection);
    on<LibraryDeleteSelected> (_deleteSelection);
    on<LibrarySortBooks> (_sortList);
  }

  void _loadBooks(LibraryLoadBooks event, Emitter<LibraryState> emit) async {
    emit(LibraryLoading());
    final databaseResult = await _getBooksUseCase.call();
    if (databaseResult is DataFailed) {
      emit(LibraryError(databaseResult.error?.message ?? "Something went wrong"));
      return;
    }

    final books = databaseResult.data;
    if (books == null || books.isEmpty) {
      emit(LibraryNoBooks());
    } else {
      emit(LibraryLoaded(books, Set()));
    }
  }

  void _addBook(LibraryAddBook event, Emitter<LibraryState> emit) async {
    emit(LibraryLoading());
    await _addBookUseCase.call(AddBookParams(path: event.filePath, title: event.title));
    add(LibraryLoadBooks());
  }

  void _toggleSelection(LibraryToggleSelection event, Emitter<LibraryState> emit) async {
    if (state is LibraryLoaded) {
      final currentState = state as LibraryLoaded;
      final updatedSet = Set<int>.from(currentState.selectedIds);

      if (updatedSet.contains(event.bookId)) {
        updatedSet.remove(event.bookId);
      } else {
        updatedSet.add(event.bookId);
      }

      emit(currentState.copyWith(selectedIds: updatedSet));
    }
  }

  void _clearSelection(LibraryClearSelection event, Emitter<LibraryState> emit) async {
    if (state is LibraryLoaded) {
      emit((state as LibraryLoaded).copyWith(selectedIds: {}));
    }
  }

  void _deleteSelection(LibraryDeleteSelected event, Emitter<LibraryState> emit) async {
    if (state is LibraryLoaded) {
      final currentState = state as LibraryLoaded;

      final updatedBooks = currentState.listOfBooks.where((book) => !currentState.selectedIds.contains(book.path)).toList();

      await _deleteBooksUseCase.call(currentState.selectedIds);

      add(LibraryLoadBooks());

      if (updatedBooks.isEmpty) {
        emit(LibraryNoBooks());
      }
    }
  }

  void _sortList(LibrarySortBooks event, Emitter<LibraryState> emit) async {
    if (state is LibraryLoaded) {
      final currentState = state as LibraryLoaded;
      final sortedList = List<BookEntity>.from(currentState.listOfBooks);

      switch (event.sortOption) {
        case SortOption.title:
          sortedList.sort((a, b) => a.title.compareTo(b.title));
          break;
        case SortOption.newest:
          sortedList.sort((a, b) => b.id.compareTo(a.id));
          break;
        case SortOption.recent:
          sortedList.sort((a, b) {
            final aDate = a.lastAccess ?? DateTime.fromMillisecondsSinceEpoch(0);
            final bDate = b.lastAccess ?? DateTime.fromMillisecondsSinceEpoch(0);
            return bDate.compareTo(aDate);
          });
          break;
      }
      emit(currentState.copyWith(listOfBooks: sortedList));
    }
  }

}