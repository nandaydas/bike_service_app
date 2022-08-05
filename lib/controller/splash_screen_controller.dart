import 'dart:async';

import 'package:bike_service_app/controller/auth_controller.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';

class SplashScreenViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  AuthController ac = Get.find<AuthController>();
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void onInit() async {
    animationInitilization();
    super.onInit();
    Timer(const Duration(milliseconds: 1500), ac.pageInitiator);
  }

  animationInitilization() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut)
            .obs
            .value;
    animation.addListener(() => update());
    animationController.forward();
  }
}
