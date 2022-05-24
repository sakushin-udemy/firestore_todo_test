import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/eitities/user.dart';
import '../../domain/value_objects/user_id.dart';
import '../constants.dart';
import '../helpers/page_mode.dart';
import '../helpers/validators.dart';
import '../view_models/user_page_vm.dart';
import '../views/atoms/gap.dart';
import '../views/organisms/action_button_area.dart';
import '../views/organisms/em_app_bar.dart';

class UserPage extends ConsumerStatefulWidget {
  const UserPage({
    Key? key,
    required this.title,
    required this.mode,
    this.userId,
  }) : super(key: key);

  static const path = '/user/:mode/:id';
  static const pathCreate = '/user/${PageMode.create}';

  final String title;
  final PageMode mode;
  final UserId? userId;

  @override
  ConsumerState<UserPage> createState() => _UserPageState();

  static String getPath(User user, PageMode pageMode) {
    return path
        .replaceFirst(pathMode, pageMode.path)
        .replaceAll(pathId, user.userId());
  }
}

class _UserPageState extends ConsumerState<UserPage> {
  final _formKey = GlobalKey<FormState>();

  late final _vm = UserPageVm(widget.userId);

  final _userIdController = TextEditingController();
  final _userNameController = TextEditingController();
  final _emailAddressController = TextEditingController();
  final _companyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _vm.setRef(ref);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EMAppbar(widget.title, context: context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                initialValue: _vm.userId?.value,
                decoration: const InputDecoration(
                  labelText: 'ユーザID', // ラベル
                  hintText: 'ユーザID(必須)', // 入力ヒント
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: notEmptyStringValidator,
                enabled: widget.mode.onlyRegister,
                onChanged: _vm.onUserIdChanged,
              ),
              Gap.h8,
              TextFormField(
                controller: _userNameController,
                decoration: const InputDecoration(
                  labelText: 'ユーザ名', // ラベル
                  hintText: 'ユーザ名(必須)', // 入力ヒント
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: notEmptyStringValidator,
                enabled: widget.mode.updatable,
                onChanged: _vm.onUserNameChanged,
              ),
              Gap.h8,
              TextFormField(
                controller: _emailAddressController,
                decoration: const InputDecoration(
                  labelText: 'Emailアドレス', // ラベル
                  hintText: 'Emailアドレス', // 入力ヒント
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: notEmptyStringValidator,
                enabled: widget.mode.updatable,
                onChanged: _vm.onEmailAddressChanged,
              ),
              Gap.h8,
              Text(_vm.errorMessage),
              ActionButtonArea(
                  pageMode: widget.mode, formKey: _formKey, vm: _vm),
            ],
          ),
        ),
      ),
    );
  }
}
