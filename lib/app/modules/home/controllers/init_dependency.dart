import 'package:get/get.dart';
import 'package:heyva_web_admin/app/modules/home/services/create_client.dart';
import 'menu_controller.dart';
import 'navigation_controllers.dart';


class InitDependency implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AdminMenuController());
    Get.lazyPut(() => NavigationController());
    Get.lazyPut(() => CreateController());
  }
}