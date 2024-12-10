import 'package:as_labs/features/authentication/controller/sign_up_controller.dart';
import 'package:as_labs/features/authentication/views/sign_in_screen.dart';
import 'package:as_labs/features/chat/screens/actions_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/colors.dart';
import '../../../utils/device.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SignUpController();

    return Scaffold(
      backgroundColor: AsColors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AsDeviceUtils.getAdaptiveResponsivePadding(context)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Create An Account",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 25),
              Text("Quickly create an account to enjoy the experience!!",
                  style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: 53),
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.email,
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: "Email",
                      ),
                      validator: (value) {},
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: controller.username,
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: "Username",
                      ),
                      validator: (value) {},
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: controller.password,
                      expands: false,
                      decoration: const InputDecoration(
                        labelText: "Password",
                      ),
                      validator: (value) {},
                    ),
                    const SizedBox(
                      height: 53,
                    ),
                    SizedBox(
                      width: AsDeviceUtils.isMobile() ? double.infinity : 200,
                      height: 47,
                      child: TextButton(
                        onPressed: () => controller.signup(),
                        child: Text(
                          "Create Account",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => Get.to(const SignInScreen()),
                      child: Text(
                        "Already have an account? Sign In",
                        style: (Theme.of(context).textTheme.labelLarge)
                            ?.copyWith(color: AsColors.white_500),
                      ),
                    ),
                    Obx(() {
                      if (controller.isSignUpLoading.value) {
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
