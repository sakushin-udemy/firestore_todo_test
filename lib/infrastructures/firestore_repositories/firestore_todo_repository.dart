import 'package:firestore_todo/domain/database/abstract_table.dart';
import 'package:firestore_todo/domain/eitities/todo.dart';
import 'package:firestore_todo/domain/repositories/base_repository.dart';
import 'package:firestore_todo/domain/repositories/todo_repository.dart';
import 'package:firestore_todo/domain/value_objects/todo_id.dart';
import 'package:firestore_todo/infrastructures/firestore_database/firestore_todo_table.dart';

class FirestoreTodoRepository //extends BaseRepository<Todo, TodoId> {
    extends TodoRepository {
  final FirestoreTodoTable todoTable;
  FirestoreTodoRepository(this.todoTable) : super(todoTable);

  @override
  Stream<List<Todo>> snapshotList(
      {int? limit, bool? isDone, bool? descending}) {
    return todoTable.snapshotList(
        limit: limit, isDone: isDone, descending: descending);
  }
}
