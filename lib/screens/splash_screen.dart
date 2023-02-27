import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:osar_pasar/screens/home.dart';
import 'package:osar_pasar/screens/auth/login.dart';
import '../controller/core_controller.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  VideoState createState() => VideoState();
}

class VideoState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  late AnimationController animationController;
  late Animation<double> animation;

  // final coreController = Get.find<CoreController>();

  final coreController = Get.put(CoreController());
  startTime() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, navigationPage);
  }

  void navigationPage() {
    if (coreController.isFirstTimeUser()) {
      Get.off(() => const OnBoarding());
    } else if (coreController.isUserLoggedIn()) {
      Get.off(() => HomePage());
    } else {
      Get.off(() => Login());
    }
  }

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: animation.value * 250,
                height: animation.value * 250,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
