import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_todo/domain/database/abstract_table.dart';
import 'package:firestore_todo/domain/value_objects/data_key.dart';

import '../../domain/eitities/todo.dart';
import '../../domain/value_objects/todo_id.dart';

class FirestoreTodoTable extends AbstractTable<Todo, TodoId> {
  static const kKey = 'todo';
  final FirebaseFirestore database;
  FirestoreTodoTable(this.database);

  CollectionReference get _collection => database.collection(kKey);

  @override
  Future<DataKey> create(Todo todo) async {
    var value = await _collection.add(todo.toJson());
    var dataKey = DataKey(value.id);
    _collection.doc(value.id).update(todo.copyWith(todoKey: dataKey).toJson());
    return dataKey;
  }

  @override
  Future<void> update(Todo todo) async {
    await _collection.doc(todo.todoKey()).update(todo.toJson());
  }

  @override
  Future<void> delete(TodoId id) async {
    var todo = await read(id: id);
    if (todo.length != 1) {
      return;
    }

    await _collection.doc(todo[0].todoKey()).delete();
  }

  @override
  Future<List<Todo>> read({TodoId? id}) async {
    var snapshot =
        (id != null ? _collection.where('id', isEqualTo: id()) : _collection)
            .get();

    List<QueryDocumentSnapshot> list = (await snapshot).docs;

    return list.map((snapshot) => snapshot.data()).map((element) {
      var data = element as Map<String, Object?>;
      var todo = Todo.fromJson(data);
      return todo;
    }).toList();
  }

  @override
  Stream<List<Todo>> snapshotList(
      {int? limit, bool? isDone, bool? descending}) {
    var collection = limit == null ? _collection : _collection.limit(limit);

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
