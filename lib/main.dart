import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main_app_entry.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(

      //     DevicePreview(
      //   enabled: !kReleaseMode,
      //   builder: (context) => const MainApp(), // Wrap your app
      // )

      const MainApp());
}
