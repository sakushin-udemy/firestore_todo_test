import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_todo/domain/value_objects/todo_id.dart';
import 'package:firestore_todo/infrastructures/firestore_database/firestore_abstract_table.dart';

import '../../domain/eitities/todo.dart';

class FirestoreTodoTable2 extends FirestoreAbstractTable<Todo, TodoId> {
  FirestoreTodoTable2(FirebaseFirestore database) : super(database);

  @override
  Todo convert(Map<String, Object?> json) {
    return Todo.fromJson(json);
  }

  @override
  String get getKey => 'todo';

  @override
  Stream<List<Todo>> snapshotList(
      {int? limit, bool? isDone, bool? descending}) {
    var collection =
        limit == null ? super.collection : super.collection.limit(limit);

    if (isDone != null) {
      collection = collection.where('isDone', isEqualTo: isDone);
    }
    collection =
        collection.orderBy('deadline', descending: descending ?? false);

    return collection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Todo.fromJson(doc.data() as Map<String, dynamic>))
        .toList());
  }
}
