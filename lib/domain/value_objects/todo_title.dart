import 'package:firestore_todo/domain/value_objects/value_object.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class TodoTitle extends ValueObject {
  TodoTitle(value) : super(value);
}

class TodoTitleConverter implements JsonConverter<TodoTitle, String> {
  const TodoTitleConverter();
  @override
  TodoTitle fromJson(String value) {
    return TodoTitle(value);
  }

  @override
  String toJson(TodoTitle value) {
    return value.value;
  }
}
