import 'package:get/get.dart';
import 'package:sqflite_crud/routes/routes.dart';

class SplashScreenController extends GetxController {
  gotoNextScreen() async {
    await Future.delayed(const Duration(seconds: 5)).then(
      (value) {
        Get.offAndToNamed(Routes.home);
      },
    );
  }

  @override
  void onInit() {
    gotoNextScreen();
    super.onInit();
  }
}
