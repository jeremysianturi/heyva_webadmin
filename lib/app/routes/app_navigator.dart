import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../modules/home/controllers/navigation_controllers.dart';
import 'app_pages.dart';

Navigator appNavigator() =>   Navigator(
  key: Get.find<NavigationController>().navigatorKey,
  onGenerateRoute: appGenerateRoute,
  initialRoute: Routes.HOME,
  // initialRoute: authenticationPageRoute,
);
