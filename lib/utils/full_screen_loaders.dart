import 'package:as_labs/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AsFullScreenLoader {
  static void openLoadingDialog(String text) {
    print("++++++++++++++++++++++++++++++++++++++");
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: Colors.white,
          width: double.infinity,
          height: double.infinity,
          child: const Column(
            children: [
              SizedBox(height: 250),
              CircularProgressIndicator(color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }

  static stopLoading(){
    Navigator.of(Get.overlayContext!).pop();
  }
}
