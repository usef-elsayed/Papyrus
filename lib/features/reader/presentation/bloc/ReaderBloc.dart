import 'dart:async';
import 'package:Papyrus/core/base/DataClass.dart';
import 'package:Papyrus/features/reader/domain/usecase/LoadBookFileUseCase.dart';
import 'package:Papyrus/features/reader/domain/usecase/UpdateBookProgressUseCase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../library/domain/entity/BookEntity.dart';
part 'ReaderEvent.dart';
part 'ReaderState.dart';

@injectable
class ReaderBloc extends Bloc<ReaderEvent,ReaderState> {

  final LoadBookFileUseCase _loadBookFileUseCase;
  final UpdateBookProgressUseCase _updateBookProgressUseCase;

  //Debouncing Logic to prevent multiple save calls
  Timer? _saveTimer;
  int _lastKnownPage = -1;
  int _currentBookId = -1;
  String? _lastKnownCfi;

  ReaderBloc(this._loadBookFileUseCase, this._updateBookProgressUseCase) : super(const ReaderLoading()){
    on<ReaderLoadBook>(_openBook);
    on<ReaderUpdateBookProgress>(_updateBookProgress);
    on<ReaderClosingEvent>(_readerClosingEvent);
  }

  void _openBook(ReaderLoadBook event, Emitter<ReaderState> emit) async {
    emit(const ReaderLoading());
    final bookExists = await _loadBookFileUseCase(event.book.path);
    if (bookExists is DataFailed) {
      emit(const ReaderError("Book not found"));
      return;
    }

    _currentBookId = event.book.id;
    _lastKnownPage = event.book.currentPage;

    if (event.book.path.endsWith('.pdf')) {
      emit(ReaderPdfReady(
        bookId: event.book.id,
        path: event.book.path,
        initialPage: event.book.currentPage,
      ));
    }
    else if (event.book.path.endsWith('.epub')) {
      emit(ReaderEpubReady(
        bookId: event.book.id,
        path: event.book.path,
        totalPages: event.book.totalPages,
        lastCfi: event.book.bookCfi,
      ));
    }

    else {
      emit(const ReaderError("Unsupported file format"));
    }
  }

  void _updateBookProgress(ReaderUpdateBookProgress event, Emitter<ReaderState> emit) async {
    _lastKnownPage = event.newPage;
    _currentBookId = event.bookId;
    _lastKnownCfi = event.currentCFI;
    _saveTimer?.cancel();
    _saveTimer = Timer(const Duration(seconds: 3), () async {
      if (isClosed) return;
      final result = await _updateBookProgressUseCase(event.bookId, event.newPage, event.currentCFI);
      if (!isClosed && result is DataFailed) {
        emit(const ReaderError("Failed to update book progress"));
      }
    });
  }

  void _readerClosingEvent(ReaderClosingEvent event, Emitter<ReaderState> emit) async {
    await _saveProgressNow();
    event.completer?.complete();
  }

  Future<void> _saveProgressNow() async {
    _saveTimer?.cancel();
    if (_lastKnownPage != -1 && _currentBookId != -1) {
      await _updateBookProgressUseCase(_currentBookId, _lastKnownPage, _lastKnownCfi);
    }
  }

}