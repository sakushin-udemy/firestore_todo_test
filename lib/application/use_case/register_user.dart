import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';

import '../../domain/database/database.dart';
import '../../domain/eitities/user.dart';
import '../../domain/exceptions/failure.dart';
import '../../domain/exceptions/register_failure.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../../domain/value_objects/user_id.dart';

class RegisterUser {
  Future<Either<Failure, User>> register(
      User registerUser, String password) async {
    Database database = GetIt.I.get<Database>();
    try {
      final authority = auth.FirebaseAuth.instance;
      auth.User? authUser = authority.currentUser;

      auth.UserCredential credential =
          await authority.createUserWithEmailAndPassword(
              email: registerUser.emailAddress(), password: password);
      authUser = credential.user;
      if (authUser == null) {
        throw DummyFailure.dummy;
      }

      UserId userId = UserId(authUser.uid);
      User user = await registerUser.copyWith(userId: UserId(userId()));
      await database.user().create(user);

      return (await database.user().selectOne(userId)).fold(
        (failure) => left(RegisterFailure()),
        (foundUser) => right(foundUser),
      );
    } on auth.FirebaseAuthException catch (e) {
      return left(RegisterFailure());
    }
  }
}
