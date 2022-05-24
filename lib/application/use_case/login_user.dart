import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firestore_todo/domain/exceptions/login_failure.dart';
import 'package:get_it/get_it.dart';
import '../../domain/database/database.dart';
import '../../domain/eitities/user.dart';
import '../../domain/exceptions/failure.dart';
import '../../domain/exceptions/register_failure.dart';
import '../../domain/value_objects/user_id.dart';

class LoginUser {
  Future<Either<Failure, User>> login(
      User registerUser, String password) async {
    Database database = GetIt.I.get<Database>();
    try {
      final authority = auth.FirebaseAuth.instance;
      auth.User? authUser = authority.currentUser;

      auth.UserCredential credential =
          await authority.signInWithEmailAndPassword(
              email: registerUser.emailAddress(), password: password);
      authUser = credential.user;
      if (authUser == null) {
        return left(LoginFailure());
      }

      UserId userId = UserId(authUser.uid);

      return (await database.user().selectOne(userId)).fold(
        (l) => left(RegisterFailure()),
        (r) => right(r),
      );
    } on auth.FirebaseAuthException catch (e) {
      return left(RegisterFailure());
    }
  }
}
