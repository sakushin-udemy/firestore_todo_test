import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:go_router/go_router.dart';

import '../../domain/database/database.dart';
import '../../domain/eitities/user.dart';
import '../../domain/exceptions/failure.dart';
import '../../domain/value_objects/data_key.dart';
import '../../domain/value_objects/email_address.dart';
import '../../domain/value_objects/user_id.dart';
import '../../domain/value_objects/user_name.dart';
import '../helpers/page_mode.dart';
import 'master_page_vm.dart';

class UserPageVm extends MasterPageVm {
  final _errorMessageProvider = StateProvider((ref) => '');

  final _userProvider = StateProvider<User>((ref) => User(
        userKey: DataKey.empty,
        userId: UserId(''),
        userName: UserName(''),
        emailAddress: EmailAddress(''),
      ));
  User get user => _ref.watch(_userProvider);

  late WidgetRef _ref;

  UserPageVm(this.userId);
  UserId? userId;

  String get errorMessage => _ref.watch(_errorMessageProvider);

  void setRef(WidgetRef ref) {
    _ref = ref;

    if (userId != null) {
      var database = GetIt.I.get<Database>();
      /*
      User.selectOne(database, userId!).then((either) {
        either.fold(
          (_) => setErrorMessage(either),
          (model) {
            _ref.read(_userProvider.notifier).update((state) => model);
            _ref.read(_userRole.notifier).update((state) => model.userRole);
            onLoaded();
          },
        );
      });*/
    }
  }

  void onUserIdChanged(String value) {
    _ref.read(_userProvider.notifier).update((state) => state.copyWith(
          userId: UserId(value),
        ));
  }

  void onUserNameChanged(String value) {
    _ref.read(_userProvider.notifier).update((state) => state.copyWith(
          userName: UserName(value),
        ));
  }

  void onEmailAddressChanged(String value) {
    _ref.read(_userProvider.notifier).update((state) => state.copyWith(
          emailAddress: EmailAddress(value),
        ));
  }

  void onActionClicked(BuildContext context, PageMode mode) async {
    var database = GetIt.I.get<Database>();
    Either<Failure, dynamic>? result;
    if (mode == PageMode.createMode) {
      result = await database.user().create(user);
    } else if (mode == PageMode.updateMode) {
      result = await database.user().update(user);
    } else if (mode == PageMode.deleteMode) {
      result = await database.user().delete(user.userId);
    }

    if (result != null && result.isLeft()) {
      setErrorMessage(result);
      return;
    }

    await showOkAlertDialog(
        context: context, title: '確認', message: '正常に${mode.btnText}しました');
  }

  void setErrorMessage(Either<Failure, dynamic> result) {
    var failure = result.swap().getOrElse(() => DummyFailure.dummy);
    _ref
        .read(_errorMessageProvider.notifier)
        .update((state) => failure.message ?? 'No message error');
  }
}
