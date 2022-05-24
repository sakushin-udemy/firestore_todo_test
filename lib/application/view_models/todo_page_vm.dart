import 'dart:async';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:dartz/dartz.dart';
import 'package:firestore_todo/domain/value_objects/todo_deadline.dart';
import 'package:firestore_todo/domain/value_objects/todo_is_done.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../domain/database/database.dart';
import '../../domain/eitities/todo.dart';
import '../../domain/exceptions/failure.dart';
import '../../domain/value_objects/data_key.dart';
import '../../domain/value_objects/todo_id.dart';
import '../../domain/value_objects/todo_title.dart';
import '../helpers/page_mode.dart';
import 'master_page_vm.dart';

/*
final _corporationListProvider =
    FutureProvider.autoDispose<List<Corporation>>((ref) async {
  var database = GetIt.I.get<Database>();
  var either = await Corporation.selectAll(database);

  List<Corporation> result = [];
  either.fold(
    (failure) => throw failure,
    (data) {
      result = data;
    },
  );
  return result;
});

final _projectListProvider = FutureProvider.autoDispose
    .family<List<Project>, DataKey?>((ref, corporationKey) async {
  List<Project> result = [];
  if (corporationKey != null) {
    var database = GetIt.I.get<Database>();
    var either =
        await Project.selectAll(database, corporationKey: corporationKey);

    either.fold(
      (failure) => throw failure,
      (data) {
        result = data;
      },
    );
  }
  return result;
});
*/
final _todoInitProvider =
    FutureProvider.autoDispose.family<Todo, String?>((ref, id) async {
  print('initProvider $id');
  var database = GetIt.I.get<Database>();
  Todo result = id != null
      ? (await database.todo().selectOne(TodoId(id)))
          .fold((failure) => throw failure, (todo) => todo)
      : Todo(
          isDone: TodoIsDone(false),
          deadline: TodoDeadline(DateTime.now()),
          todoId: TodoId(''),
          title: TodoTitle(''),
          todoKey: DataKey.empty,
        );

  return result;
});

class TodoPageVm extends MasterPageVm {
  late WidgetRef _ref;

  TodoPageVm(this.todoId);

  final String? todoId;
/*
  AsyncValue<List<Corporation>> get corporationList =>
      _ref.watch(_corporationListProvider);
  AsyncValue<List<Project>> projectList(DataKey? corporationKey) =>
      _ref.watch(_projectListProvider(corporationKey));*/
  AsyncValue<Todo> todoInit(String? id) => _ref.watch(_todoInitProvider(id));

  /*
  final _corporationProvider = StateProvider<Corporation?>((ref) => null);
  Corporation? get corporation => _ref.watch(_corporationProvider);

  final _projectProvider = StateProvider<Project?>((ref) => null);
  Project? get project => _ref.watch(_projectProvider);
*/
  final _todoProvider = StateProvider<Todo?>((ref) => null);
  Todo? get todo => _ref.watch(_todoProvider);

  final _errorMessageProvider = StateProvider((ref) => '');
  String get errorMessage => _ref.watch(_errorMessageProvider);

  void setRef(WidgetRef ref) async {
    _ref = ref;
  }

  void onTodoLoaded(Todo todo) {
    if (_ref.read(_todoProvider) != null) {
      return;
    }

    _ref.read(_todoProvider.notifier).update((state) => todo);
  }

/*
  void onCorporationChanged(Corporation? corporation) {
    _ref.read(_corporationProvider.notifier).update((state) => corporation);
    if (corporation != null) {
      _ref.read(_todoProvider.notifier).update(
            (state) => state!.copyWith(
              corporationKey: corporation.corporationKey,
              corporationName: corporation.corporationName,
            ),
          );
      _ref.read(_projectProvider.notifier).update((state) => null);
    }
  }

  void onProjectChanged(Project? project) {
    _ref.read(_projectProvider.notifier).update((state) => project);
    if (project != null) {
      _ref.read(_todoProvider.notifier).update((state) => state!.copyWith(
            projectKey: project.projectKey,
            projectName: project.projectName,
          ));
    }
  }
*/
  void onTodoIdChanged(String value) {
    _ref
        .read(_todoProvider.notifier)
        .update((state) => state!.copyWith(todoId: TodoId(value)));
  }

  void onTitleChanged(String value) {
    _ref
        .read(_todoProvider.notifier)
        .update((state) => state!.copyWith(title: TodoTitle(value)));
  }

  void onDeadlineChanged(DateTime? value) {
    if (value != null) {
      _ref
          .read(_todoProvider.notifier)
          .update((state) => state!.copyWith(deadline: TodoDeadline(value)));
    }
  }

  @override
  void onActionClicked(BuildContext context, PageMode mode) async {
    var database = GetIt.I.get<Database>();

    Either<Failure, dynamic>? result;
    if (mode == PageMode.createMode) {
      result = await database.todo().create(todo!);
    } else if (mode == PageMode.updateMode) {
      result = await database.todo().update(todo!);
    } else if (mode == PageMode.deleteMode) {
      result = await database.todo().delete(todo!.todoId);
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
