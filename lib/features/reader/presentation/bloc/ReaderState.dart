part of 'ReaderBloc.dart';
class ReaderState extends Equatable {
  const ReaderState();
  @override
  List<Object?> get props => [];
}

class ReaderLoading extends ReaderState {
  const ReaderLoading();
}

class ReaderPdfReady extends ReaderState {
  final int bookId;
  final String path;
  final int initialPage;

  const ReaderPdfReady({required this.bookId, required this.path, required this.initialPage});

  @override
  List<Object> get props => [bookId, path, initialPage];
}

class ReaderEpubReady extends ReaderState {
  final int bookId;
  final String path;
  final int totalPages;
  final String? lastCfi;
  const ReaderEpubReady({required this.bookId, required this.path, required this.totalPages, required this.lastCfi});

  @override
  List<Object> get props => [bookId, path, totalPages];
}

class ReaderError extends ReaderState {
  final String message;
  const ReaderError(this.message);
}