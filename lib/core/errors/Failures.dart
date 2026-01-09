abstract class Failure {
  final String message;
  Failure(this.message);
}

class GenericFailure extends Failure {
  GenericFailure([super.message = "Something went wrong"]);
}

class DatabaseFailure extends Failure {
  DatabaseFailure([super.message = "Database error occurred"]);
}

class BookProcessingFailure extends Failure {
  BookProcessingFailure([super.message = "Book processing error occurred"]);
}

class BookUndefinedFailure extends Failure {
  BookUndefinedFailure([super.message = "Book processing error occurred"]);
}