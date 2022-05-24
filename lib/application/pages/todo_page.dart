import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain/eitities/todo.dart';
import '../constants.dart';
import '../helpers/page_mode.dart';
import '../helpers/validators.dart';
import '../view_models/todo_page_vm.dart';
import '../views/atoms/gap.dart';
import '../views/organisms/action_button_area.dart';
import '../views/organisms/em_app_bar.dart';

class TodoPage extends ConsumerStatefulWidget {
  const TodoPage({
    Key? key,
    required this.title,
    required this.mode,
    this.todoId,
  }) : super(key: key);

  static const path = '/todo/:mode/:id';
  static const pathCreate = '/todo/${PageMode.create}';

  final String title;
  final PageMode mode;
  final String? todoId;

  @override
  ConsumerState<TodoPage> createState() => _TodoPageState();

  static String getPath(Todo todo, PageMode pageMode) {
    return path
        .replaceFirst(pathMode, pageMode.path)
        .replaceAll(pathId, todo.todoId());
  }
}

class _TodoPageState extends ConsumerState<TodoPage> {
  final _formKey = GlobalKey<FormState>();

  late TodoPageVm _vm;

  @override
  void initState() {
    super.initState();

    _vm = TodoPageVm(widget.todoId);
    _vm.setRef(ref);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EMAppbar(widget.title, context: context),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: _vm.todoInit(widget.todoId).when(
              error: (err, _) => Text(err.toString()),
              loading: () => const CircularProgressIndicator(),
              data: (initData) {
                WidgetsBinding.instance
                    ?.addPostFrameCallback((_) => _vm.onTodoLoaded(initData));

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'TodoID',
                        hintText: '1234',
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: notEmptyStringValidator,
                      enabled: widget.mode.onlyRegister,
                      onChanged: _vm.onTodoIdChanged,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'タイトル',
                        hintText: '原稿を書く',
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: notEmptyStringValidator,
                      enabled: widget.mode.updatable,
                      onChanged: _vm.onTitleChanged,
                      initialValue: initData.title(),
                    ),
                    Gap.h8,
                    DateTimeField(
                      enabled: widget.mode.updatable,
                      initialValue: initData.deadline(),
                      decoration: const InputDecoration(
                        labelText: '完了予定日',
                        hintText: '2022/01/01',
                      ),
                      format: DateFormat('yyyy/MM/dd'),
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          initialDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365 * 3)),
                        );
                      },
                      onChanged: _vm.onDeadlineChanged,
                      onSaved: (DateTime? value) {},
                    ),
                    Gap.h8,
                    Text(_vm.errorMessage),
                    ActionButtonArea(
                        pageMode: widget.mode, formKey: _formKey, vm: _vm),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
