import 'package:get/get.dart';
import 'menu_controller.dart';
import 'navigation_controllers.dart';


class InitDependency implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminMenuController());
    Get.lazyPut(() => NavigationController());
  }
}