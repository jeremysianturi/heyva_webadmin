import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constant/colors.dart';
import '../../constant/strings.dart';

class DeleteAccountDialog {
  static show({required Function ontap}) {
    Get.defaultDialog(
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      title: '',
      backgroundColor: ColorApp.white.withOpacity(0.8),
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            const Text(
              Strings.deleteAccountTitl,
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: ColorApp.blue_container,
                  fontSize: 28),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              Strings.deleteAccountSub,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: ColorApp.blue_container,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: Get.width,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(12)),
                        border: Border.all(color: ColorApp.blue_container),
                      ),
                      child: const Text(
                        Strings.cancel,
                        style: TextStyle(
                            color: ColorApp.blue_container,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            ontap();
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                color: ColorApp.btn_orange),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    Strings.continue_text,
                                    style: TextStyle(
                                        color: ColorApp.arrow_white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  ImageIcon(
                                    AssetImage("assets/icons/ic_arrow_right.png"),
                                    color: ColorApp.arrow_white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ],
        ),
      ),
      radius: 10.0,
    );
  }
}