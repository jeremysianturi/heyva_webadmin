import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heyva_web_admin/app/routes/app_pages.dart';

import 'app/controllers/auth_controller.dart';
import 'firebase_options.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  var scrollController = ScrollController();
  final authC = Get.put(AuthController(), permanent: true);

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "HEYVA",
      initialRoute: Routes.SPLASH_SCREEN,
      getPages: AppPages.routes,
      // getPages: [
      //   GetPage(name: Routes.PRIVACY_POLICY, page: () => PrivacyPolicyView()),
      //   GetPage(name: Routes.LOGIN, page: () => LoginView()),
      //   GetPage(name: Routes.TERMS_OF_SERVICE, page: () => TermsOfServiceView())
      // ],
    );

    // FutureBuilder(
    //   future: Future.delayed(const Duration(seconds: 1)),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const SplashScreen();
    //     } else {
    //       final authC = Get.find<AuthController>();
    //       return StreamBuilder<User?>(
    //           stream: authC.streamAuthStatus,
    //           builder: (context, snapshot) {
    //             // authC.setLoginStatus(snapshot.data != null);
    //             // var box = GetStorage();
    //             // authToken = box.read(Keys.loginAccessToken).toString();
    //             // refreshToken = box.read(Keys.loginRefreshToken).toString();
    //             debugPrint("auth token $authToken");
    //             // var loginC = Get.put(LoginController());
    //             // loginC.refresh();
    //
    //             // if (authToken != "null" && refreshToken != "null") {
    //             //   return GetMaterialApp(
    //             //     debugShowCheckedModeBanner: false,
    //             //     title: "HEYVA",
    //             //     initialRoute: Routes.INITIAL_PAGE,
    //             //     getPages: AppPages.routes,
    //             //   );
    //             // }
    //             return GetMaterialApp(
    //               debugShowCheckedModeBanner: false,
    //               title: "HEYVA",
    //               initialRoute: "/termsofservice",
    //               // getPages: AppPages.routes,
    //               getPages: [
    //                 GetPage(
    //                     name: Routes.PRIVACY_POLICY,
    //                     page: () => PrivacyPolicyView()),
    //                 GetPage(name: "/", page: () => LoginView()),
    //                 GetPage(
    //                     name: "/termsofservice",
    //                     page: () => TermsOfServiceView())
    //               ],
    //             );
    //           });
    //     }
    //   });
  }
}
