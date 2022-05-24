import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/list_page_vm.dart';
import '../views/molecules/em_list_tile.dart';
import '../views/organisms/em_app_bar.dart';

class ListPage<T> extends ConsumerWidget {
  const ListPage({
    required this.title,
    required this.vm,
    Key? key,
    required this.getTitle,
    required this.getSubtitle,
  }) : super(key: key);

  final String title;
  final ListPageVm vm;

  final String Function(T value) getTitle;
  final String Function(T value) getSubtitle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: EMAppbar(title, context: context),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => vm.onAddTapped(context),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 64),
        child: vm.items(ref).when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text(err.toString())),
              data: (items) {
                return ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (_, index) {
                    var item = items[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: EMListTile<T>(
                        onTapped: (item, pageMode) =>
                            vm.onTapped(context, item, pageMode),
                        item: item,
                        getTitle: getTitle,
                        getSubtitle: getSubtitle,
                      ),
                    );
                  },
                );
              },
            ),
      ),
    );
  }
}
