import 'package:firestore_todo/domain/value_objects/value_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class TodoId extends ValueObject {
  TodoId(value) : super(value);
}

class TodoIdConverter implements JsonConverter<TodoId, String> {
  const TodoIdConverter();
  @override
  TodoId fromJson(String value) {
    return TodoId(value);
  }

  @override
  String toJson(TodoId value) {
    return value.value;
  }
}
