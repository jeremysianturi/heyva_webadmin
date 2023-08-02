import 'package:get/get.dart';

import '../controllers/others_controller.dart';

class OthersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OthersController>(
      () => OthersController(),
    );
  }
}