import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../domain/database/database.dart';
import '../helpers/page_mode.dart';

typedef FuncSnapshotAll<T> = Stream<List<T>> Function();
typedef FuncGetPath<T> = String Function(T item, PageMode pageMode);

class ListPageVm<T> {
  late final _listProvider = StreamProvider.autoDispose<List<T>>((ref) {
    return funcSnapshot();
  });

  AsyncValue<List<T>> items(WidgetRef ref) => ref.watch(_listProvider);

  ListPageVm(this.funcGetPath, this.funcSnapshot);

  final FuncSnapshotAll<T> funcSnapshot;
  final FuncGetPath<T> funcGetPath;

  void onTapped(BuildContext context, T item, PageMode pageMode) {
    GoRouter.of(context).push(funcGetPath(item, pageMode));
  }

  void onAddTapped(BuildContext context) {
    GoRouter.of(context).push(
      GoRouter.of(context).location.replaceAll('/list', '/create'),
    );
  }
}
