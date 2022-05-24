import '../../domain/repositories/user_repository.dart';
import '../firestore_database/firestore_user_table.dart';

class FirestoreUserRepository extends UserRepository {
  final FirestoreUserTable userTable;
  FirestoreUserRepository(this.userTable) : super(userTable);
}
