import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/splash_screen/splash_screen_controller.dart';

class SplashScreen extends GetView<SplashScreenController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
      init: SplashScreenController(), //////////// call splash screen controller
      builder: (controller) {
        //////////// only loading message show
        return const Scaffold(
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Loading.....")
            ],
          )),
        );
      },
    );
  }
}
