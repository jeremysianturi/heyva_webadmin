import 'package:flutter/material.dart';

import '../views/dashboard_view.dart';
import '../views/logout_view.dart';
import '../views/post_article_video.dart';
import '../views/user_view.dart';
import '../views/post_article.dart';
import '../views/read_article.dart';
import 'menu_controller.dart';
import 'navigation_controllers.dart';

const adminPageDisplayName = "Admin";
const adminPageRoute = "/admin";

const dashboardPageDisplayName = "Dashboard";
const dashboardPageRoute = "/admin/dashboard";

const createPageDisplayName = "New Article";
const createPageRoute = "/admin/create";

const createVideoPageDisplayName = "New Article Video";
const createVideoPageRoute = "/admin/create-video";

// const updatePageDisplayName = "Update Article";
// const updatePageRoute = "/admin/update";

const readPageDisplayName = "View Article";
const readPageRoute = "/admin/read";

const userPageDisplayName = "User";
const userPageRoute = "/admin/user";

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
  MenuItem(createVideoPageDisplayName, createVideoPageRoute),
  // MenuItem(updatePageDisplayName, updatePageRoute),
  MenuItem(readPageDisplayName, readPageRoute),
  MenuItem(userPageDisplayName, userPageRoute),
  MenuItem(logoutPageDisplayName, logoutPageRoute)
];


Route<dynamic>? toGenerateRoute(RouteSettings settings){
  switch (settings.name) {
    case adminPageRoute:
      return _getPageRoute(ExitPage(), settings);
    case dashboardPageRoute:
      return _getPageRoute(DashboardPage(), settings);
    case createPageRoute:
      return _getPageRoute(CreateArticlePage(), settings);
    case createVideoPageRoute:
      return _getPageRoute(CreateArticleVideoPage(), settings);
    // case updatePageRoute:
    //   return _getPageRoute(UpdateArticlePage(), settings);
    case readPageRoute:
      return _getPageRoute(ViewArticlePage(), settings);
    case userPageRoute:
      return _getPageRoute(UserView(), settings);
    case logoutPageRoute:
      return _getPageRoute(ExitPage(), settings);
    // default:
    //   return _getPageRoute(DashboardPage(), settings);

  }
  return null;
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
