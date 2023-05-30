import 'package:get/get.dart';

import '../controllers/privacypolicy_controller.dart';

class PrivacyPolicyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrivacyPolicyController>(
          () => PrivacyPolicyController(),
    );
  }
}