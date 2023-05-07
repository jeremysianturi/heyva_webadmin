import 'package:flutter/material.dart';

import '../controllers/menu_controller.dart';
import '../controllers/navigation_controllers.dart';


class AdminLayout extends StatelessWidget {
  final Widget child;
  const AdminLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: <Widget>[
            Expanded(
              child: AdminPageMenu(),
            ),
            Expanded(
              flex: 5,
              // child: localNavigator(),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}


class HomeAdminView extends StatelessWidget {
  const HomeAdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('Admin entry thru admin_layout instead of admin_page.');
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: <Widget>[
            Expanded(
              child: AdminPageMenu(),
            ),
            Expanded(
              flex: 5,
              child: localNavigator(),
            ),
          ],
        ),
      ),
    );
  }
}
