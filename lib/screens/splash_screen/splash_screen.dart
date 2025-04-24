import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_icons_path.dart';
import '../../widgets/icon_widget/icon_widget.dart';
import 'controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  final splashController = Get.put(SplashScreenController());

  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AnnotatedRegion(
      value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Center(
          child: IconWidget(
            icon: AppIconsPath.appLogo,
            height: 207,
            width: 207,
          ),
        ),
      ),
    );
  }
}
