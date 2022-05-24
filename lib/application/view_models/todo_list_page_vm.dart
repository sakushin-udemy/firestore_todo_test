import 'package:firestore_todo/domain/value_objects/todo_is_done.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../domain/database/database.dart';
import '../../domain/eitities/todo.dart';
import '../helpers/page_mode.dart';

typedef FuncSnapshotAll<T> = Stream<List<T>> Function();
typedef FuncGetPath<T> = String Function(T item, PageMode pageMode);

class TodoListPageVm {
  final database = GetIt.I.get<Database>();

  late final _listProvider = StreamProvider.autoDispose<List<Todo>>((ref) {
    var database = GetIt.I.get<Database>();
    return database.todo().snapshotList(
          limit: ref.watch(_limitProvicer),
          //isDone: ref.watch(_isDoneShow),
          descending: ref.watch(_isDescending),
        );
  });

  AsyncValue<List<Todo>> items(WidgetRef ref) => ref.watch(_listProvider);

  final _limitProvicer = StateProvider<int>((ref) => 20);
  final _isDoneShow = StateProvider<bool>((ref) => false);
  final _isDescending = StateProvider<bool>((ref) => false);

  TodoListPageVm(this.funcGetPath);

  final FuncGetPath<Todo> funcGetPath;

  void onTapped(BuildContext context, Todo item, PageMode pageMode) {
    GoRouter.of(context).push(funcGetPath(item, pageMode));
  }

  void onAddTapped(BuildContext context) {
    GoRouter.of(context).push(
      GoRouter.of(context).location.replaceAll('/list', '/create'),
    );
  }

  void onCheckTapped(Todo item) {
    TodoIsDone isDone = TodoIsDone(!item.isDone());
    database.todo().update(item.copyWith(isDone: isDone));
  }
}
