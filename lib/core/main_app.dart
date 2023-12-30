import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_crud/routes/app_pages.dart';
import 'package:sqflite_crud/utils/theme.dart';

import '../logic/main_app/main_app_controller.dart';

class MainApp extends GetView<MainAppController> {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MainAppController(),
      builder: (context) {
        return GetMaterialApp(
          title: "Sqflite crud",
          theme: appThemeData,
          initialRoute: AppPage.initialRoutes,
          getPages: AppPage.appPages,
        );
      },
    );
  }
}
