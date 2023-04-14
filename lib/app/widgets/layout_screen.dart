import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:heyva_web_admin/app/widgets/side_menu.dart';

import '../modules/home/views/dashboard_view.dart';


class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: <Widget>[
            const Expanded(
              child: SideMenu(),
            ),
            Expanded(
              flex: 5,
              child: Container(
                color: Colors.white,
                child: DashboardPage(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
