import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heyva_web_admin/app/routes/app_pages.dart';
import 'app/modules/home/controllers/menu_controller.dart';
import 'app/modules/home/controllers/navigation_controllers.dart';
import 'app/modules/login/controllers/login_controller.dart';
import 'firebase_options.dart';
import 'app/controllers/auth_controller.dart';
import 'app/modules/splashscreen/splashscreen.dart';

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
  final loginC = Get.put(LoginController(), permanent: true);
  final menuController = Get.put(AdminMenuController(), permanent: true);
  final navigationController = Get.put(NavigationController(), permanent: true);
  // final adminController = Get.put(CreateController(), permanent: true);

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return FutureBuilder(
        future: Future.delayed(const Duration(seconds: 1)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else {
            final authC = Get.find<AuthController>();
            return StreamBuilder<User?>(
                stream: authC.streamAuthStatus,
                builder: (context, snapshot) {
                  // authC.setLoginStatus(snapshot.data != null);
                  // var box = GetStorage();
                  // authToken = box.read(Keys.loginAccessToken).toString();
                  // refreshToken = box.read(Keys.loginRefreshToken).toString();
                  // debugPrint("auth token $authToken");
                  // var loginC = Get.put(LoginController());
                  // loginC.refresh();

                  // if (authToken != "null" && refreshToken != "null") {
                  //   return GetMaterialApp(
                  //     debugShowCheckedModeBanner: false,
                  //     title: "HEYVA",
                  //     initialRoute: Routes.INITIAL_PAGE,
                  //     getPages: AppPages.routes,
                  //   );
                  // }
                  return GetMaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: "HEYVA",
                    // initialRoute: Routes.LOGIN,try
                    theme: Theme.of(context).copyWith(
                      colorScheme: Theme.of(context).colorScheme.copyWith(
                        primary: const Color(0xFFEC9BAD),
                      ),
                    ),
                    // initialBinding: InitDependency(),
                    // builder: (context, child) => AdminLayout(child: child!),
                    // navigatorKey: navigationController.navigatorKey,
                    // onGenerateRoute: toGenerateRoute,
                    // initialRoute: adminPageRoute,
                    // initialRoute: dashboardPageRoute,
                    initialRoute: AppPages.INITIAL,
                    getPages: AppPages.routes,
                  );
                });
          }
        });
  }
}
