import 'package:firestore_todo/domain/database/abstract_table.dart';
import 'package:firestore_todo/domain/repositories/base_repository.dart';

import '../eitities/todo.dart';
import '../value_objects/todo_id.dart';

abstract class TodoRepository extends BaseRepository<Todo, TodoId> {
  TodoRepository(AbstractTable<Todo, TodoId> table) : super(table);

  Stream<List<Todo>> snapshotList({int? limit, bool? isDone, bool? descending});
}
