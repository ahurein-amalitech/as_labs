import 'package:as_labs/features/authentication/controller/onboarding_controller.dart';
import 'package:as_labs/features/authentication/views/sign_in_screen.dart';
import 'package:as_labs/utils/colors.dart';
import 'package:as_labs/utils/device.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(OnboardingController());

    return Scaffold(
      backgroundColor: AsColors.black,
      body: Stack(
        children: [
          Center(
            child: Image.asset("assets/images/logo.png"),
          ),
          const SizedBox(
            height: 100,
          ),
          Positioned(
            bottom: 30,
            left: (AsDeviceUtils.getScreenWidth(context) / 2) - 25,
            child: const CircularProgressIndicator(color: Colors.white),
          )
        ],
      ),
    );
  }
}
