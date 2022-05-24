import 'package:flutter/material.dart';

import '../../helpers/page_mode.dart';
import '../../view_models/master_page_vm.dart';
import '../atoms/gap.dart';

class ActionButtonArea extends StatelessWidget {
  const ActionButtonArea({
    Key? key,
    required this.pageMode,
    required this.formKey,
    required this.vm,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final PageMode pageMode;
  final MasterPageVm vm;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Visibility(
          visible: pageMode != PageMode.readMode,
          child: OutlinedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                vm.onActionClicked(context, pageMode);
              }
            },
            child: Text(pageMode.btnText),
          ),
        ),
        Gap.w10,
        OutlinedButton(
          onPressed: () {
            vm.onCancelClicked(context);
          },
          child: Text('戻る'),
        ),
      ],
    );
  }
}
