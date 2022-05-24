import 'package:firestore_todo/domain/repositories/base_repository.dart';

import '../eitities/todo.dart';
import '../eitities/user.dart';
import '../repositories/todo_repository.dart';
import '../value_objects/todo_id.dart';
import '../value_objects/user_id.dart';

abstract class Database {
  TodoRepository todo();
  BaseRepository<User, UserId> user();
}
