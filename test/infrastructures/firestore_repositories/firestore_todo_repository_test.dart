import 'package:firestore_todo/domain/eitities/todo.dart';
import 'package:firestore_todo/domain/value_objects/data_key.dart';
import 'package:firestore_todo/domain/value_objects/todo_deadline.dart';
import 'package:firestore_todo/domain/value_objects/todo_id.dart';
import 'package:firestore_todo/domain/value_objects/todo_is_done.dart';
import 'package:firestore_todo/domain/value_objects/todo_title.dart';
import 'package:firestore_todo/infrastructures/firestore_database/firestore_todo_table.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

main() {
  test('basic', () async {
    final firestore = FakeFirebaseFirestore();
    final repository = FirestoreTodoTable(firestore);

    final todo1 = Todo(
      todoKey: DataKey.empty,
      id: TodoId('1'),
      title: TodoTitle('title1'),
      isDone: TodoIsDone(false),
      deadline: TodoDeadline(
        DateTime(2023, 1, 1),
      ),
    );

    final resSelectAll1 = (await repository.read());
    expect(resSelectAll1.length, 0);

    // insert
    await repository.create(todo1);

    final resSelectAll2 = (await repository.read());
    expect(resSelectAll2.length, 1);

    final todo1_ = resSelectAll2[0];
    expect(todo1.id, todo1_.id);
    expect(todo1.title, todo1_.title);
    expect(todo1.deadline, todo1_.deadline);
    expect(todo1.isDone, todo1_.isDone);

    expect(todo1.todoKey, DataKey.empty);
    expect(todo1.todoKey, isNot(todo1_.todoKey));

    final todo2 = todo1_.copyWith(
      title: TodoTitle('title1_updated'),
      isDone: TodoIsDone(true),
    );

    // update
    await repository.update(todo2);

    final resSelectAll3 = (await repository.read());
    expect(resSelectAll3.length, 1);

    final todo2_ = resSelectAll3[0];
    expect(todo2_.id, todo1_.id);
    expect(todo2_.title(), 'title1_updated');
    expect(todo2_.deadline, todo1_.deadline);
    expect(todo2_.isDone(), true);

    // delete
    await repository.delete(todo2.id);
    final resSelectAll4 = (await repository.read());
    expect(resSelectAll4.length, 0);
  });
}
