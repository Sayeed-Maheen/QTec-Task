import 'package:get/get.dart';
import 'package:qtec_task/screens/home_screen/home_screen.dart';
import 'package:qtec_task/screens/splash_screen/splash_screen.dart';

import 'app_routes.dart';

class RouteManager {
  static const initial = AppRoutes.splashScreen;

  static List<GetPage> getPages() {
    return [
      GetPage(
        name: AppRoutes.splashScreen,
        page: () => SplashScreen(),
        // binding: GeneralBindings(),
      ),
      GetPage(
        name: AppRoutes.homeScreen,
        page: () => HomeScreen(),
        // binding: GeneralBindings(),
      ),
    ];
  }
}
