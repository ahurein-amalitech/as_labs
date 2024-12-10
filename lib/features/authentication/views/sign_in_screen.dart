import 'package:as_labs/features/authentication/controller/sign_in_controller.dart';
import 'package:as_labs/features/authentication/views/sign_up_screen.dart';
import 'package:as_labs/features/chat/screens/actions_screen.dart';
import 'package:as_labs/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/device.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SignInController();

    return Scaffold(
      backgroundColor: AsColors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: AsDeviceUtils.getAdaptiveResponsivePadding(context)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "You're Almost There",
                style: Theme
                    .of(context)
                    .textTheme
                    .titleLarge,
              ),
              const SizedBox(height: 25),
              Text("Login to get the fun started",
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodySmall),
              const SizedBox(height: 53),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      expands: false,
                      controller: controller.username,
                      decoration: const InputDecoration(
                        labelText: "Username",
                      ),
                      validator: (value) {},
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      expands: false,
                      controller: controller.password,
                      decoration: const InputDecoration(
                        labelText: "Password",
                      ),
                      validator: (value) {},
                    ),
                    const SizedBox(
                      height: 53,
                    ),
                    SizedBox(
                      width: AsDeviceUtils.isMobile() ? double.infinity : 150,
                      height: 47,
                      child: TextButton(
                        onPressed: () {
                          controller.login();
                        },
                        child: Text(
                          "Sign In",
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyMedium,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => Get.to(const SignUpScreen()),
                      // onTap: () => Get.to(const ActionScreen()),
                      child: Text(
                        "Dont have an account? Sign Up",
                        style: (Theme
                            .of(context)
                            .textTheme
                            .labelLarge)
                            ?.copyWith(color: AsColors.white_500),
                      ),
                    ),
                    Obx(() {
                      if (controller.isSignInLoading.value) {
                        return const SizedBox(height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                              color: AsColors.white),);
                      }
                      return const SizedBox.shrink();
                    })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
