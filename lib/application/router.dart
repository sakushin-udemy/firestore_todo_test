import 'package:firestore_todo/application/helpers/utilities.dart';
import 'package:firestore_todo/application/pages/list_page.dart';
import 'package:firestore_todo/application/pages/login_page.dart';
import 'package:firestore_todo/application/pages/todo_list_page.dart';
import 'package:firestore_todo/application/pages/todo_page.dart';
import 'package:firestore_todo/application/pages/user_page.dart';
import 'package:firestore_todo/application/view_models/list_page_vm.dart';
import 'package:firestore_todo/application/view_models/todo_list_page_vm.dart';
import 'package:firestore_todo/domain/database/database.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../domain/eitities/todo.dart';
import '../domain/eitities/user.dart';
import '../domain/value_objects/user_id.dart';
import 'helpers/page_mode.dart';

final router = GoRouter(
  initialLocation: '/todo/list', // ReserveIntroPage.path,
  routes: [
    GoRoute(
      path: LoginPage.path,
      pageBuilder: (BuildContext context, GoRouterState? state) {
        return const MaterialPage(
          child: LoginPage(
            title: 'ようこそ!',
          ),
        );
      },
    ),
    GoRoute(
      path: TodoPage.pathCreate,
      pageBuilder: (BuildContext context, GoRouterState? state) {
        final paramMode = state?.params['mode'] ?? PageMode.create;
        final mode = PageMode.convert(paramMode); // convertPageMode(paramMode);

        return MaterialPage(
            child: TodoPage(
          title: 'ToDo (新規登録)',
          mode: mode,
        ));
      },
    ),
    GoRoute(
      path: TodoPage.path,
      pageBuilder: (BuildContext context, GoRouterState? state) {
        final paramMode = state!.params['mode']!;
        final mode = PageMode.convert(paramMode);
        final id = state.params['id']!;
        return MaterialPage(
          child: TodoPage(
            todoId: id,
            mode: mode,
            title: 'ToDo',
          ),
        );
      },
    ),
    GoRoute(
      path: '/todo/list',
      pageBuilder: (BuildContext context, GoRouterState? state) {
        return MaterialPage(
          child: TodoListPage(
            title: 'ToDo 一覧',
            vm: TodoListPageVm(
              TodoPage.getPath,
            ),
            getTitle: (value) => value.title(),
            getSubtitle: (value) =>
                '${Utilities.dateToString(value.deadline())}まで (id: ${value.todoId()})',
          ),
        );
      },
    )
  ],
/*    redirect: (state) {
      if (state.location == LoginPage.path ||
          state.location.startsWith(CorporationPage.path)) {
        return null;
      }

      final user = LoginUserInfo().loginUser;
      if (user == null) {
        return LoginPage.path;
      }
      return null;
    }*/
);
