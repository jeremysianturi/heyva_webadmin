import 'package:get/get.dart';
import '../controllers/termsofservice_controller.dart';

class TermsOfServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TermsOfServiceController>(
          () => TermsOfServiceController(),
    );
  }
}