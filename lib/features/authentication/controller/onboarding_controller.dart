import 'dart:async';

import 'package:as_labs/features/authentication/views/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController{
  Timer? _redirectTimer;

  void startRedirectionTimer() {
    _redirectTimer?.cancel();
    _redirectTimer = Timer(const Duration(seconds: 2), () {
      Get.off(() => const SignInScreen());
    });
  }

  @override
  void onInit() {
    super.onInit();
    startRedirectionTimer();
  }
}