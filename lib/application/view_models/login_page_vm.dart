import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/eitities/user.dart';
import '../../domain/exceptions/failure.dart';
import '../../domain/exceptions/register_failure.dart';
import '../../domain/value_objects/data_key.dart';
import '../../domain/value_objects/email_address.dart';
import '../../domain/value_objects/user_id.dart';
import '../../domain/value_objects/user_name.dart';
import '../helpers/login_user_info.dart';
import '../use_case/login_user.dart';
import '../use_case/register_user.dart';

class LoginPageVm {
  final _userProvider = StateProvider<User>(
    (ref) => User(
        userKey: DataKey.empty,
        userId: UserId(''),
        userName: UserName(''),
        emailAddress: EmailAddress('')),
  );
  final _passwordProvider = StateProvider<String>((ref) => '');
  final _passwordConfirmProvider = StateProvider<String>((ref) => '');
  final _registerProvider = StateProvider<bool>((ref) => false);
  final _errorMessageProvider = StateProvider<String>((ref) => '');

  bool get isRegister => _ref.watch(_registerProvider);
  String get errorMessage => _ref.watch(_errorMessageProvider);

  LoginPageVm();

  late final WidgetRef _ref;

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  void onRegisterChanged(bool? value) {
    _ref.read(_registerProvider.notifier).update((state) => value ?? false);
  }

  void onUserNameChanged(String value) {
    _ref
        .read(_userProvider.notifier)
        .update((state) => state.copyWith(userName: UserName(value)));
  }

  /*
  void onCompanyChanged(String value) {
    _ref
        .read(_userProvider.notifier)
        .update((state) => state.copyWith(company: Company(value)));
  }*/

  void onEmailAddressChanged(String value) {
    _ref
        .read(_userProvider.notifier)
        .update((state) => state.copyWith(emailAddress: EmailAddress(value)));
  }

  void onPasswordChanged(String value) {
    _ref.read(_passwordProvider.notifier).update((state) => value);
  }

  void onPasswordConfirmChanged(String value) {
    _ref.read(_passwordConfirmProvider.notifier).update((state) => value);
  }

  void onClick(BuildContext context) async {
    bool isRegister = _ref.read(_registerProvider);
    Either<Failure, User> result = isRegister
        ? await (RegisterUser()
            .register(_ref.read(_userProvider), _ref.read(_passwordProvider)))
        : await (LoginUser()
            .login(_ref.read(_userProvider), _ref.read(_passwordProvider)));

    result.fold(
      (err) => _ref
          .read(_errorMessageProvider.notifier)
          .update((state) => err.toString()),
      (user) {
        LoginUserInfo().login(user);
      },
    );
  }
}
