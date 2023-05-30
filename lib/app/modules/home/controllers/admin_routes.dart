import 'package:flutter/material.dart';

import '../views/dashboard_view.dart';
import '../views/dummy_pages.dart';
import '../views/post_article.dart';
import '../views/read_article.dart';
import '../views/update_article.dart';
import 'menu_controller.dart';
import 'navigation_controllers.dart';

const adminPageDisplayName = "Admin";
const adminPageRoute = "/admin";

const dashboardPageDisplayName = "Dashboard";
const dashboardPageRoute = "/admin/dashboard";

const createPageDisplayName = "New Article";
const createPageRoute = "/admin/create";

const updatePageDisplayName = "Update Article";
const updatePageRoute = "/admin/update";

const readPageDisplayName = "View Article";
const readPageRoute = "/admin/read";

const settingPageDisplayName = "Setting";
const settingPageRoute = "/admin/setting";

const logoutPageDisplayName = "Logout";
const logoutPageRoute = "/admin/logout";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

AdminMenuController menuController = AdminMenuController.instance;
NavigationController navigationController = NavigationController.instance;


List<MenuItem> sideMenuItemRoutes = [
  MenuItem(dashboardPageDisplayName, dashboardPageRoute),
  MenuItem(createPageDisplayName, createPageRoute),
  MenuItem(updatePageDisplayName, updatePageRoute),
  MenuItem(readPageDisplayName, readPageRoute),
  MenuItem(settingPageDisplayName, settingPageRoute),
  MenuItem(logoutPageDisplayName, logoutPageRoute)
];


Route<dynamic> toGenerateRoute(RouteSettings settings){
  switch (settings.name) {
    case adminPageRoute:
      return _getPageRoute(DashboardPage(), settings);
    case dashboardPageRoute:
      return _getPageRoute(DashboardPage(), settings);
    case createPageRoute:
      return _getPageRoute(CreateArticlePage(), settings);
    case updatePageRoute:
      return _getPageRoute(UpdateArticlePage(), settings);
    case readPageRoute:
      return _getPageRoute(ViewArticlePage(), settings);
    case settingPageRoute:
      return _getPageRoute(const SettingPage(), settings);
    case logoutPageRoute:
      return _getPageRoute(ExitPage(), settings);
    default:
      return _getPageRoute(DashboardPage(), settings);

  }
}

// PageRoute _getPageRoute(Widget child, RouteSettings settings){
//   return MaterialPageRoute(builder: (context) => child, settings: settings);
// }

PageRoute _getPageRoute(Widget child, RouteSettings settings){
  return _FadeRoute(child: child, routeName: settings.name!);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;
  _FadeRoute({required this.child, required this.routeName})
      : super(
    settings: RouteSettings(name: routeName),
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    child,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: animation,
          child: child,
        ),
  );
}
