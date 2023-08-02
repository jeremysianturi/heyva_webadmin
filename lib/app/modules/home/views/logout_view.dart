import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';

class ExitPage extends StatelessWidget {
  ExitPage({Key? key}) : super(key: key);
  final logoutCtrl = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
        slivers: [
          SliverGrid.count(
              crossAxisCount: 1,
              childAspectRatio: 10,
              children: [
                GestureDetector(
                  // onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'EXIT',
                      ),
                    ),
                  ),
                ),
              ]
          ),
          SliverGrid.count(
              crossAxisCount: 1,
              childAspectRatio: 2,
              children: [
                GestureDetector(
                  onTap: () {
                    logoutCtrl.logout();
                  },
                  child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Text('Logout')
                    // child: TextField(
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(),
                    //     labelText: 'EXIT',
                    //   ),
                    // ),
                  ),
                ),
              ]
          ),
        ]);
  }
}