import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'admin_routes.dart';


class NavigationController extends GetxController{
  static NavigationController instance = Get.find();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  Future<dynamic> navigateTo(String routeName){
    return navigatorKey.currentState!.pushNamed(routeName);
  }

  goBack() => navigatorKey.currentState!.pop();

}

Navigator localNavigator() =>   Navigator(
  // key: Get.find<NavigationController>().navigatorKey,
  key: navigationController.navigatorKey,
  onGenerateRoute: toGenerateRoute,
  initialRoute: dashboardPageRoute,
);
