import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_todo/domain/database/database.dart';
import 'package:firestore_todo/domain/eitities/todo.dart';
import 'package:firestore_todo/domain/eitities/user.dart';
import 'package:firestore_todo/domain/repositories/base_repository.dart';
import 'package:firestore_todo/domain/value_objects/todo_id.dart';
import 'package:firestore_todo/domain/value_objects/user_id.dart';
import 'package:firestore_todo/infrastructures/firestore_database/firestore_todo_table.dart';
import 'package:firestore_todo/infrastructures/firestore_database/firestore_user_table.dart';
import 'package:firestore_todo/infrastructures/firestore_repositories/firestore_todo_repository.dart';
import 'package:get_it/get_it.dart';

import '../../domain/repositories/todo_repository.dart';
import '../firestore_repositories/firestore_todo_repository2.dart';
import '../firestore_repositories/firestore_user_repository.dart';
import 'firestore_todo_table2.dart';

class FirestoreDatabase extends Database {
  final FirebaseFirestore database = GetIt.I.get<FirebaseFirestore>();

  late final TodoRepository _todo = FirestoreTodoRepository2(
    FirestoreTodoTable2(database),
  );

  late final BaseRepository<User, UserId> _user = FirestoreUserRepository(
    FirestoreUserTable(database),
  );

  @override
  TodoRepository todo() {
    return _todo;
  }

  @override
  BaseRepository<User, UserId> user() {
    return _user;
  }
}
