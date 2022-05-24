import 'package:firestore_todo/domain/value_objects/value_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class TodoDeadline extends ValueObject<DateTime> {
  TodoDeadline(value) : super(value);
}

class TodoDeadlineConverter implements JsonConverter<TodoDeadline, String> {
  const TodoDeadlineConverter();
  @override
  TodoDeadline fromJson(String value) {
    return TodoDeadline(DateTime.parse(value).toLocal());
  }

  @override
  String toJson(TodoDeadline value) {
    return value.value.toLocal().toString();
  }
}
