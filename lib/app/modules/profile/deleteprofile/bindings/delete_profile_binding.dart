import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:heyva_web_admin/app/modules/profile/deleteprofile/controllers/delete_profile_controller.dart';

class DeleteProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeleteProfileController>(
          () => DeleteProfileController(),
    );
  }
}