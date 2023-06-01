import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../../../constant/colors.dart';
import '../../../../../constant/strings.dart';
import '../../../../widgets/delete_account_dialog.dart';
import '../controllers/delete_profile_controller.dart';

class DeleteProfileView extends GetView<DeleteProfileController> {
  DeleteProfileView({super.key});
  final deleteProfileController = Get.put(DeleteProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              DeleteAccountDialog.show(ontap: () {
                Get.back();
                Future.delayed(200.milliseconds, () {
                  controller.deleteAccount();
                });
              });
            },
            child: Container(
              color: Colors.transparent,
              width: Get.width,
              padding: const EdgeInsets.symmetric(vertical: 28),
              child: const Text(
                Strings.deletedAccount,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: ColorApp.blue_container,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w700),
              ),
            ),
          )
        ],
      )
    );
  }
}