import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // Wait for 3 seconds before navigating to the HomeScreen
    Future.delayed(const Duration(seconds: 3)).then((_) {
      Get.offAllNamed(AppRoutes.productScreen);
      //Get.to(() => BottomNavy());
    });
  }

  @override
  void onClose() {
    super.onClose();
    print("SplashController disposed"); // Log message to confirm disposal
  }
}
