part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const SIGNUP = _Paths.SIGNUP;
  static const LOGIN = _Paths.LOGIN;
  static const REGISTER = _Paths.REGISTER;
  static const PRIVACY_POLICY = _Paths.PRIVACY_POLICY;
  static const TERMS_OF_SERVICE = _Paths.TERMS_OF_SERVICE;
  static const RESET_PASSWORD = _Paths.RESET_PASSWORD;
  static const SPLASH_SCREEN = _Paths.SPLASH_SCREEN;
  static const FORGOT_PASSWORD = _Paths.FORGOT_PASSWORD;
}

abstract class _Paths {
  _Paths._();

  static const SIGNUP = '/signup';
  static const LOGIN = '/login';
  static const REGISTER = '/register';
  static const PRIVACY_POLICY = '/privacypolicy';
  static const TERMS_OF_SERVICE = '/termsofservice';
  static const RESET_PASSWORD = '/resetpassword/:userid/:request_reset_password_token';
  static const SPLASH_SCREEN = '/splash-screen';
  static const FORGOT_PASSWORD = '/forgotpassword';
}
