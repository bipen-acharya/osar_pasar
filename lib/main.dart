import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osar_pasar/screens/home.dart';
import 'package:osar_pasar/screens/splash_screen.dart';
import 'package:osar_pasar/utils/theme.dart';

import 'controller/home_controller.dart';

void main() {
  Get.put(HomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: basicTheme(),
      home:  Scaffold(
        body: SplashScreen(),
      ),
    );
  }
}
