import 'dart:js';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:heyva_web_admin/app/modules/others/views/others_page.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/admin_layout.dart';
import '../modules/home/views/dashboard_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/others/bindings/others_binding.dart';
import '../modules/privacypolicy/bindings/privacypolicy_binding.dart';
import '../modules/privacypolicy/views/privacypolicy_view.dart';
import '../modules/resetpassword/bindings/resetpassword_binding.dart';
import '../modules/resetpassword/views/resetpassword_view.dart';
import '../modules/termsofservice/bindings/termsofservice_binding.dart';
import '../modules/termsofservice/views/termsofservice_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  // static const INITIAL = Routes.rHOME;
  static const INITIAL = Routes.LOGIN;
  // static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PRIVACY_POLICY,
      page: () => PrivacyPolicyView(),
      binding: PrivacyPolicyBinding(),
    ),
    GetPage(
      name: _Paths.TERMS_OF_SERVICE,
      page: () => TermsOfServiceView(),
      binding: TermsOfServiceBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      // page: () => const HomeViewAdmin(),
      // page: () => const ProviderScope(child: HomeViewAdmin()),
      // page: () => const HomeAdminView(),
      page: () => DashboardPage(),
      binding: HomeBinding(),
    ),
    // GetPage(
    //   name: _Paths.HOME,
    //   page: () => OthersView(),
    //   binding: OthersBinding(),
    // ),
  ];
}

Route<dynamic> appGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.LOGIN:
      return _appGetPageRoute(LoginView(), settings);
    case Routes.PRIVACY_POLICY:
      return _appGetPageRoute(PrivacyPolicyView(), settings);
    case Routes.TERMS_OF_SERVICE:
      return _appGetPageRoute(TermsOfServiceView(), settings);
    case Routes.RESET_PASSWORD:
      return _appGetPageRoute(ResetPasswordView(), settings);
    case Routes.HOME:
      return _appGetPageRoute(const HomeAdminView(), settings);
    default:
      return _appGetPageRoute(LoginView(), settings);
  }
}

PageRoute _appGetPageRoute(Widget child, RouteSettings settings) {
  return MaterialPageRoute(builder: (context) => child, settings: settings);
}

// class _FadeRoute extends PageRouteBuilder {
//   final Widget child;
//   final String routeName;
//   _FadeRoute({required this.child, required this.routeName})
//       : super(
//     settings: RouteSettings(name: routeName),
//     pageBuilder: (
//         BuildContext context,
//         Animation<double> animation,
//         Animation<double> secondaryAnimation,
//         ) =>
//     child,
//     transitionsBuilder: (
//         BuildContext context,
//         Animation<double> animation,
//         Animation<double> secondaryAnimation,
//         Widget child,
//         ) =>
//         FadeTransition(
//           opacity: animation,
//           child: child,
//         ),
//   );
// }
