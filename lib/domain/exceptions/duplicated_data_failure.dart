import 'failure.dart';

class DuplicatedDataFailure extends Failure {
  DuplicatedDataFailure(
    String message, {
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
