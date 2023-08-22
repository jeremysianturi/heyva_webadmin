import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:heyva_web_admin/app/modules/home/controllers/navigation_controllers.dart';
import 'package:heyva_web_admin/app/modules/home/views/admin_common.dart';
import '../../../../constant/colors.dart';
import 'admin_routes.dart';

enum SideMenuItems {
  dashboard,
  newArticle,
  newArticleVideo,
  viewArticle,
  user,
  logout
}

List<String> sideMenuItems = const [
  'Dashboard',
  'New Article',
  'New Article Video',
  // 'Update Article',
  'View Article',
  'User',
  'Logout',
];

final _menuPageIcons = <String, String>{
  'Dashboard': 'assets/icons/menu_dashbord.svg',
  'New Article': 'assets/icons/menu_tran.svg',
  'New Article Video': 'assets/icons/menu_tran.svg',
  // 'Update Article': 'assets/icons/menu_task.svg',
  'View Article': 'assets/icons/menu_doc.svg',
  'User': 'assets/icons/menu_setting.svg',
  'Logout': 'assets/images/icon_exit.png',
};

class AdminMenuController extends GetxController {
  static AdminMenuController instance = Get.find();
  var activeItem = dashboardPageDisplayName.obs;

  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isHovering(String itemName) => hoverItem.value == itemName;

  isActive(String itemName) => activeItem.value == itemName;

  Widget drawerTileMenu(String itemName) {
    NavigationController navigationController = Get.find<NavigationController>();
    return ListTile(
      // onTap: fPress,
      onTap: () {
        if (!isActive(itemName)) {
          changeActiveItemTo(itemName);
          navigationController.navigateTo(sideMenuItemRoutes.firstWhere((e) => e.name == itemName).route);
        }
      },
      leading: _menuPageIcons[itemName].toString().contains('svg') ?
        Obx(() => SvgPicture.asset(
          _menuPageIcons[itemName].toString(),
          color: isActive(itemName) ? ColorApp.btn_pink : Colors.black,
          height: 16,
        ))
        : Obx(() => Image.asset(
          _menuPageIcons[itemName].toString(),
          color: isActive(itemName) ? ColorApp.btn_pink : Colors.black,
          height: 16,
        )),
      horizontalTitleGap: 0.2,
      title: Obx(() => Text(
          itemName,
          style: isActive(itemName) ?
          const TextStyle(
            fontWeight: FontWeight.bold,
            color: ColorApp.btn_pink,
          )
              : const TextStyle(
            color: Colors.black87,
          )
      )),
    );
  }
}

class AdminPageMenu extends StatelessWidget {
  AdminPageMenu({super.key});
  AdminMenuController menuController = Get.find<AdminMenuController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: SvgPicture.asset(
                "assets/images/heyva_logo.svg",
              ),
            ),
            Divider(color: Colors.grey.withOpacity(.1), ),
            Column(children: sideMenuItemRoutes
              .map((item) => menuController.drawerTileMenu(item.name)).toList()),
          ],
        ),
      ),
    );
  }
}
