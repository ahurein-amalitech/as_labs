import 'package:as_labs/features/authentication/views/onboarding.dart';
import 'package:as_labs/utils/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        inputDecorationTheme: AsTheme.darkInputTheme,
        textTheme: AsTheme.textTheme,
        textButtonTheme: AsTheme.textButtonTheme
      ),
      home: Scaffold(
        body: OnboardingPage(),
      ),
    );
  }
}