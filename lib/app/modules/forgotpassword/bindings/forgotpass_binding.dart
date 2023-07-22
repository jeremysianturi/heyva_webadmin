import 'package:get/get.dart';
import 'package:heyva_web_admin/app/modules/forgotpassword/controllers/forgotpass_controller.dart';

class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(
          () => ForgotPasswordController(),
    );
  }
}