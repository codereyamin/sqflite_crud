import 'package:get/get.dart';
import 'package:sqflite_crud/logic/home_screen/home_screen_controller.dart';
import 'package:sqflite_crud/logic/splash_screen/splash_screen_controller.dart';
import 'package:sqflite_crud/presentations/home/home_screen.dart';
import 'package:sqflite_crud/presentations/splash/splash_screen.dart';
import 'package:sqflite_crud/routes/routes.dart';

import '../core/main_app.dart';
import '../logic/main_app/main_app_controller.dart';

class AppPage {
  static const String initialRoutes = Routes.splash;
  static List<GetPage> appPages = [
    //////////// root app
    GetPage(
      name: Routes.mainApp,
      page: () => const MainApp(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<MainAppController>(
            () => MainAppController(),
          );
        },
      ),
    ),

    ////////////// splash screen
    /// initial page show and loading indicator
    /// user interactive app and show app is running sometime wait
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<SplashScreenController>(
            () => SplashScreenController(),
          );
        },
      ),
    ),

    /////////////// home page

    GetPage(
      name: Routes.home,
      page: () => const HomeScreen(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<HomeScreenController>(
            () => HomeScreenController(),
          );
        },
      ),
    ),
  ];
}
