import 'package:get/get.dart';
import 'package:sqflite_crud/routes/routes.dart';

class SplashScreenController extends GetxController {
  ////////// create next screen go function
  gotoNextScreen() async {
    /////////// delay or wait function 3 seconds
    await Future.delayed(const Duration(seconds: 3)).then(
      (value) {
        ///////// after waiting go to home page
        ///
        ///remove previews screen
        Get.offAndToNamed(Routes.home);
      },
    );
  }

  @override
  void onInit() {
    /////////// call next screen go function
    gotoNextScreen();
    super.onInit();
  }
}
