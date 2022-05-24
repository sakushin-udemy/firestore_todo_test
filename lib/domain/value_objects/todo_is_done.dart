import 'package:firestore_todo/domain/value_objects/value_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class TodoIsDone extends ValueObject<bool> {
  TodoIsDone(value) : super(value);
}

class TodoIsDoneConverter implements JsonConverter<TodoIsDone, String> {
  const TodoIsDoneConverter();
  @override
  TodoIsDone fromJson(String value) {
    return TodoIsDone(value == 'true');
  }

  @override
  String toJson(TodoIsDone value) {
    return value.value.toString();
  }
}
