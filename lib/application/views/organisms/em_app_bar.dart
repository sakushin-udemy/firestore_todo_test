import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../helpers/login_user_info.dart';
import '../../pages/login_page.dart';
import '../molecules/em_app_bar_button.dart';

class EMAppbar extends AppBar {
  EMAppbar(
    String title, {
    Key? key,
    required BuildContext context,
  }) : super(
          key: key,
          title: Text(title),
          toolbarHeight: 70,
          elevation: 14,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(70),
              bottomLeft: Radius.circular(70),
            ),
          ),
          /* actions: [
              Row(
                children: [
                  EmAppBarButton(
                    iconData: Icons.logout,
                    onTap: () {
                      LoginUserInfo().logoff();
                      GoRouter.of(context).push(LoginPage.path);
                    },
                  ),
                ],
              )
            ]*/
        );
}
