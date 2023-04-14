import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../constant/strings.dart';
import '../controllers/privacypolicy_controller.dart';

class PrivacyPolicyView extends GetView<PrivacyPolicyController> {
  PrivacyPolicyView({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg_web.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("privacy isinya")
          ],
        ),
      ),
    );
  }
}

