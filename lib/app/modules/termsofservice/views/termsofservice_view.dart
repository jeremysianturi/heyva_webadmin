import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/termsofservice_controller.dart';

class TermsOfServiceView extends GetView<TermsOfServiceController> {
  TermsOfServiceView({super.key});
  final termsController = Get.put(TermsOfServiceController());

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
            Text(termsController.termsOfServiceText)
          ],
        ),
      ),
    );
  }
}

