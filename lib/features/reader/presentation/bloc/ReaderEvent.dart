part of 'ReaderBloc.dart';

class ReaderEvent extends Equatable {
  const ReaderEvent();

  @override
  List<Object?> get props => [];
}

class ReaderLoadBook extends ReaderEvent {
  final BookEntity book;
  const ReaderLoadBook(this.book);

  @override
  List<Object> get props => [book];
}

class ReaderUpdateBookProgress extends ReaderEvent {
  final int bookId;
  final int newPage;
  final String? currentCFI;
  const ReaderUpdateBookProgress(this.bookId, this.newPage, this.currentCFI);

  @override
  List<Object> get props => [bookId, newPage];
}

class ReaderClosingEvent extends ReaderEvent {
  final Completer<void>? completer;
  const ReaderClosingEvent(this.completer);
}