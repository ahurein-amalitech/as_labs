import 'package:as_labs/features/authentication/controller/sign_in_controller.dart';
import 'package:as_labs/features/chat/screens/ask_chat_screen.dart';
import 'package:as_labs/features/chat/screens/cv_chat_screen.dart';
import 'package:as_labs/features/chat/screens/query_chat.dart';
import 'package:as_labs/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/device.dart';

class ActionScreen extends StatelessWidget {
  const ActionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());

    return Scaffold(
      backgroundColor: AsColors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AsDeviceUtils.getAdaptiveResponsivePadding(context)),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(top: 100),
                  child: IconButton(onPressed: () => controller.logout(), icon: Icon(Icons.logout, color: Colors.white))),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/images/logo.png"),
                  const SizedBox(height: 52),
                  SizedBox(
                    width: double.infinity,
                    height: 47,
                    child: TextButton(
                      onPressed: () => Get.to(const AskChatScreen()),
                      child: Text(
                        "Amali Buddy",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                  const SizedBox(height: 34),
                  SizedBox(
                    width: double.infinity,
                    height: 47,
                    child: TextButton(
                      onPressed: () => Get.to( const CvReviewScreen()),
                      child: Text(
                        "CV Review",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                  const SizedBox(height: 34),
                  SizedBox(
                    height: 47,
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () => Get.to(const QueryFileChat()),
                      child: Text(
                        "Query A Pdf",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}
