import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../helpers/page_mode.dart';

abstract class MasterPageVm {
  void onActionClicked(BuildContext context, PageMode mode);
  void onCancelClicked(BuildContext context) {
    GoRouter.of(context).pop();
  }
}
