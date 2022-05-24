import 'package:flutter/material.dart';

import '../../helpers/page_mode.dart';

typedef ListTileTapped<T> = void Function(T category, PageMode pageMode);

class EMListTile<T> extends StatelessWidget {
  const EMListTile({
    Key? key,
    required this.item,
    required this.onTapped,
    required this.getTitle,
    required this.getSubtitle,
    this.leading,
  }) : super(key: key);

  final T item;

  final Widget? leading;
  final ListTileTapped<T> onTapped;
  final String Function(T value) getTitle;
  final String Function(T value) getSubtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Text(
        getTitle(item),
      ),
      subtitle: Text(
        '${getSubtitle(item)}',
      ),
      onTap: () => onTapped(item, PageMode.readMode),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () {
          showMenu<PageMode>(
            context: context,
            position: const RelativeRect.fromLTRB(25.0, 25.0, 0.0, 0.0),
            items: [
              PopupMenuItem<PageMode>(
                  child: Row(
                    children: const [
                      Icon(Icons.edit),
                      Text('修正'),
                    ],
                  ),
                  value: PageMode.updateMode),
              PopupMenuItem<PageMode>(
                  child: Row(
                    children: const [
                      Icon(Icons.delete),
                      Text('削除'),
                    ],
                  ),
                  value: PageMode.deleteMode),
            ],
          ).then((mode) {
            if (mode != null) {
              onTapped(item, mode);
            }
          });
        },
      ),
    );
  }
}
