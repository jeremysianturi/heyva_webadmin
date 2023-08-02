part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const SIGNUP = _Paths.SIGNUP;
  static const LOGIN = _Paths.LOGIN;
  static const REGISTER = _Paths.REGISTER;
  static const PRIVACY_POLICY = _Paths.PRIVACY_POLICY;
  static const TERMS_OF_SERVICE = _Paths.TERMS_OF_SERVICE;
  static const RESET_PASSWORD = _Paths.RESET_PASSWORD;
<<<<<<< HEAD
  static const HOME = _Paths.HOME;
  static const OTHERS = _Paths.OTHERS;
=======
  static const SPLASH_SCREEN = _Paths.SPLASH_SCREEN;
  static const FORGOT_PASSWORD = _Paths.FORGOT_PASSWORD;
  static const DELETE_ACCOUNT = _Paths.DELETE_ACCOUNT;
>>>>>>> 64b537176efe83695f2badc6fc12448d0c01149d
}

abstract class _Paths {
  _Paths._();

  static const SIGNUP = '/signup';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const PRIVACY_POLICY = '/privacypolicy';
  static const TERMS_OF_SERVICE = '/termsofservice';
<<<<<<< HEAD
  static const RESET_PASSWORD = '/resetpassword';
  static const HOME = '/admin';
  static const OTHERS = '/others';
=======
  static const RESET_PASSWORD = '/resetpassword/:userid/:request_reset_password_token';
  static const SPLASH_SCREEN = '/splash-screen';
  static const FORGOT_PASSWORD = '/forgotpassword';
  static const DELETE_ACCOUNT = '/deleteaccount';
>>>>>>> 64b537176efe83695f2badc6fc12448d0c01149d
}
