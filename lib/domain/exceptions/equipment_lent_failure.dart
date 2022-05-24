import 'failure.dart';

class EquipmentLentFailure extends Failure {
  EquipmentLentFailure(
    String message, {
    StackTrace? stackTrace,
  }) : super(
          message: message,
          stackTrace: stackTrace,
        );
}
