import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../helpers/validators.dart';
import '../view_models/login_page_vm.dart';
import '../views/atoms/gap.dart';
import '../views/organisms/em_app_bar.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({
    Key? key,
    required this.title,
  }) : super(key: key);

  static const path = '/login';
  final String title;

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late final _vm = LoginPageVm();

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
              Row(
                children: [
                  Checkbox(
                      value: _vm.isRegister, onChanged: _vm.onRegisterChanged),
                  Text('初めて使用するために登録する'),
                ],
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'E-mail Address', // ラベル
                  hintText: 'ichiro-suzuki@kyotoss.co.jp', // 入力ヒント
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: notEmptyStringValidator,
                onChanged: _vm.onEmailAddressChanged,
              ),
              Gap.h8,
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'パスワード', // ラベル
                  hintText: 'password', // 入力ヒント
                ),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: notEmptyStringValidator,
                onChanged: _vm.onPasswordChanged,
                obscureText: true,
              ),
              if (_vm.isRegister) ...[
                Gap.h8,
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'パスワードの確認', // ラベル
                    hintText: 'password', // 入力ヒント
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: notEmptyStringValidator,
                  onChanged: _vm.onPasswordConfirmChanged,
                  obscureText: true,
                ),
                Gap.h16,
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '氏名', // ラベル
                    hintText: '鈴木 一郎', // 入力ヒント
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: notEmptyStringValidator,
                  onChanged: _vm.onUserNameChanged,
                ),
              ],
              Gap.h16,
              OutlinedButton(
                onPressed: () => _vm.onClick(context),
                child: Text(_vm.isRegister ? '登録' : 'ログイン'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
