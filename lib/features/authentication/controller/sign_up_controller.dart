import 'package:as_labs/features/authentication/views/sign_in_screen.dart';
import 'package:as_labs/features/chat/screens/actions_screen.dart';
import 'package:as_labs/utils/api_service.dart';
import 'package:as_labs/utils/as_loaders.dart';
import 'package:as_labs/utils/full_screen_loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final storage = GetStorage();

  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();

  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final apiService = ApiService();
  final isSignUpLoading = false.obs;

  signup() async {
    try {
      isSignUpLoading.value = true;
      final payload = {
        "username": username.text,
        "password": password.text,
        "email": email.text
      };
      final response = await apiService.post("/auth/signup", data: payload);
      AsLoaders.successSnackBar(title: response.data["message"]);
      Get.off(() => const SignInScreen());
    } finally {
      isSignUpLoading.value = false;
    }
  }
}
