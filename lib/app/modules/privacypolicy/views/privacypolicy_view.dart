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
<<<<<<< HEAD
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          _parseHtmlString(privacyController.privacyPolicyText)!,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
=======
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
>>>>>>> 64b537176efe83695f2badc6fc12448d0c01149d
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

