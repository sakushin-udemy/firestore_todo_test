import 'package:firestore_todo/domain/eitities/base_entity.dart';
import 'package:firestore_todo/domain/value_objects/todo_deadline.dart';
import 'package:firestore_todo/domain/value_objects/todo_id.dart';
import 'package:firestore_todo/domain/value_objects/todo_is_done.dart';
import 'package:firestore_todo/domain/value_objects/todo_title.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../value_objects/data_key.dart';

part 'todo.g.dart';
part 'todo.freezed.dart';

@freezed
class Todo extends BaseEntity<TodoId> with _$Todo {
  const Todo._();
  const factory Todo({
    @TodoIdConverter() required TodoId id,
    @DataKeyConverter() required DataKey todoKey,
    @TodoTitleConverter() required TodoTitle title,
    @TodoDeadlineConverter() required TodoDeadline deadline,
    @TodoIsDoneConverter() required TodoIsDone isDone,
    //@DataKeyConverter() required DataKey projectKey,
    //required String projectName,
    //required String corporationName,
    //@DataKeyConverter() required DataKey corporationKey,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  @override
  TodoId get idValue => id;

  @override
  Todo setDataKey(DataKey key) {
    return copyWith(todoKey: key);
  }

  @override
  Todo convert(Map<String, Object?> json) {
    return Todo.fromJson(json);
  }

  @override
  DataKey get dataKey => todoKey;
}
