import 'package:as_labs/features/authentication/views/sign_in_screen.dart';
import 'package:as_labs/features/chat/screens/actions_screen.dart';
import 'package:as_labs/utils/api_service.dart';
import 'package:as_labs/utils/as_loaders.dart';
import 'package:as_labs/utils/full_screen_loaders.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final storage = GetStorage();

  final username = TextEditingController();
  final password = TextEditingController();

  GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  final apiService = ApiService();
  final isSignInLoading = false.obs;

  login() async {
    try{
      isSignInLoading.value = true;
      await storage.write("token", "");
      final payload = {"username": username.text, "password": password.text};
      final response = await apiService.post("/auth/signin", data: payload );
      await storage.write("token", response.data["content"]["token"]);
      AsLoaders.successSnackBar(title: response.data["message"]);
      Get.off(() => const ActionScreen());
    }finally{
      isSignInLoading.value = false;
    }
  }

  logout() async {
    try{
      await storage.write("token", "");
      Get.off(() => const SignInScreen());
    }catch(e){}
  }
}