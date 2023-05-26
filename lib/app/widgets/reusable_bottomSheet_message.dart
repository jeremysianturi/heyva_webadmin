import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

bottomSheetMessage({String desc = "", String color = "red"}) {

  var colorText = Colors.white;
  var colorBg = Colors.green;
  if (color == "red") {
    colorText = Colors.white;
    colorBg = Colors.red;
  } else if (color == "yellow") {
    colorText = Colors.white;
    colorBg = Colors.yellow;
  } else {
    // green
    colorText = Colors.white;
    colorBg = Colors.green;
  }

  return Get.bottomSheet(
    Container(
      decoration: BoxDecoration(
          color: colorBg,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                desc,
                style : TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: colorText,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    ),
    isDismissible: true,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10))),
    enableDrag: false,
  );
}