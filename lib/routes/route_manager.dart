import 'package:get/get.dart';
import 'package:qtec_task/home_screen/home_screen.dart';

import 'app_routes.dart';

class RouteManager {
  static const initial = AppRoutes.homeScreen;

  static List<GetPage> getPages() {
    return [
      GetPage(
        name: AppRoutes.homeScreen,
        page: () => HomeScreen(),
        // binding: GeneralBindings(),
      ),
    ];
  }
}
