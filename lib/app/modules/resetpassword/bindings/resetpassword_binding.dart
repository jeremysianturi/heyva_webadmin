import 'package:get/get.dart';
import '../controllers/resetpassword_controller.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordController>(
          () => ResetPasswordController(),
    );
  }
}