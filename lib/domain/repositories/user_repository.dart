import 'package:firestore_todo/domain/database/abstract_table.dart';
import 'package:firestore_todo/domain/repositories/base_repository.dart';

import '../eitities/user.dart';
import '../value_objects/user_id.dart';

abstract class UserRepository extends BaseRepository<User, UserId> {
  UserRepository(AbstractTable<User, UserId> table) : super(table);
}
