import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heyva_web_admin/app/modules/home/services/read_client.dart';
import 'package:heyva_web_admin/app/modules/home/views/read_article.dart';
import 'package:heyva_web_admin/constant/colors.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../controllers/admin_routes.dart';
import '../controllers/menu_controller.dart';
import '../services/dashboard_client.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({Key? key}) : super(key: key);

  static ReadUserController readUserCtrl = Get.find<ReadUserController>();
  static ReadController readArticleCtrl = Get.find<ReadController>();
  static AdminMenuController adminMenuCtrl = Get.find<AdminMenuController>();
  final _multiSelectKey = GlobalKey<FormFieldState>();
  late String userId;

  void initReadUsers() async {
    await readUserCtrl.initUserList();
  }

  void initTotalArticle() async {
    await readArticleCtrl.getArticleTotal();
  }

  void goSeeArticlePage() {
    adminMenuCtrl.changeActiveItemTo(readPageDisplayName);
    navigationController.navigateTo(sideMenuItemRoutes.firstWhere((e) =>
    e.name == readPageDisplayName).route);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    String pageName = sideMenuItems[SideMenuItems.dashboard.index];

    if(readUserCtrl.cachedUserList.isEmpty) {
      initReadUsers();
    }

    if(readArticleCtrl.totalArticleProd.value == 0) {
      initTotalArticle();
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Card(
              elevation: 70,
              shadowColor: Colors.black,
              color: Colors.white,
              child: SizedBox(
                width: 300,
                height: 500,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() =>CircularPercentIndicator(
                        radius: 100.0,
                        animation: true,
                        animationDuration: 1200,
                        lineWidth: 20,
                        percent: 80/100,
                        center: Text(
                          "${readArticleCtrl.totalArticleProd.value}/${readArticleCtrl.totalArticle.value} Articles",
                          style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        backgroundColor: Colors.white,
                        progressColor: ColorApp.btn_pink,
                      ),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () => {
                              goSeeArticlePage()
                            },
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(ColorApp.btn_pink),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                children: const [
                                  Icon(Icons.touch_app),
                                  Text('See article list')
                                ],
                              ),
                            ),
                          ),
                        ],
                      ) //SizedBox
                    ],
                  ), //Column
                ), //Padding
              ), //SizedBox
            ),
            Card(
              elevation: 70,
              shadowColor: Colors.black,
              color: Colors.white,
              child: SizedBox(
                width: 300,
                height: 500,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() => CircularPercentIndicator(
                        radius: 100.0,
                        animation: true,
                        animationDuration: 1200,
                        lineWidth: 20,
                        percent: 80/100,
                        center: Text(
                          "${readUserCtrl.nbrOfUsers.value}/100 Users",
                          style:
                          const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        backgroundColor: Colors.white,
                        progressColor: ColorApp.btn_pink,
                      ),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () => 'Null',
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all(ColorApp.btn_pink),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                children: const [
                                  Icon(Icons.touch_app),
                                  Text('See user list')
                                ],
                              ),
                            ),
                          ),
                        ],
                      ) //SizedBox
                    ],
                  ), //Column
                ), //Padding
              ), //SizedBox
            ),
          ],
        ),
      ),
    );
  }
}
