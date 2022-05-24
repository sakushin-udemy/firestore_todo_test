import 'failure.dart';

class DataNotFoundFailure extends Failure {
  DataNotFoundFailure(
    String message, {
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
