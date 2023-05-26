import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';

import '../controllers/privacypolicy_controller.dart';

class PrivacyPolicyView extends GetView<PrivacyPolicyController> {
  PrivacyPolicyView({super.key});
  final privacyController = Get.put(PrivacyPolicyController());

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
          child: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      // child: Html(
                      //   data: """${termsController.termsOfServiceText}""",
                      // ),
                      child: Text(
                        _parseHtmlString(privacyController.privacyPolicyText)!,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text(termsController.termsOfServiceText)
        //   ],
        // ),
      ),
    );
  }

  //here goes the function
  String? _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String? parsedString = parse(document.body?.text).documentElement?.text;

    return parsedString;
  }
}

