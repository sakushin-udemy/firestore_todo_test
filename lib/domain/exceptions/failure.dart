abstract class Failure {
  final String? message;
  final StackTrace? stackTrace;

  Failure({this.message, this.stackTrace});
}

class DummyFailure extends Failure {
  static DummyFailure dummy = DummyFailure();
}
