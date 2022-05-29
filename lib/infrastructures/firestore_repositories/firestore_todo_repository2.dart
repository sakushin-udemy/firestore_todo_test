import '../../domain/eitities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../firestore_database/firestore_todo_table.dart';
import '../firestore_database/firestore_todo_table2.dart';

class FirestoreTodoRepository2 //extends BaseRepository<Todo, TodoId> {
    extends TodoRepository {
  final FirestoreTodoTable2 todoTable2;
  FirestoreTodoRepository2(this.todoTable2) : super(todoTable2);

  @override
  Stream<List<Todo>> snapshotList(
      {int? limit, bool? isDone, bool? descending}) {
    return todoTable2.snapshotList(
        limit: limit, isDone: isDone, descending: descending);
  }
}
