import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:heyva_web_admin/app/modules/forgotpassword/bindings/forgotpass_binding.dart';
import 'package:heyva_web_admin/app/modules/forgotpassword/views/forgotpass_view.dart';
import 'package:heyva_web_admin/app/modules/profile/deleteprofile/bindings/delete_profile_binding.dart';
import 'package:heyva_web_admin/app/modules/profile/deleteprofile/views/delete_profile_view.dart';
import 'package:heyva_web_admin/app/modules/splaschscreen/bindings/splash_screen_binding.dart';
import 'package:heyva_web_admin/app/modules/splaschscreen/views/splash_screen_view.dart';

import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
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
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.DELETE_ACCOUNT,
      page: () => DeleteProfileView(),
      binding: DeleteProfileBinding(),
    ),
  ];
}
