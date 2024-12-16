import 'package:bustracking/nav.dart';
import 'package:bustracking/src/features/authentication/screens/splash_screen/onboarding_screen/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/splash_screen/splash_screen2.dart';
import '../screens/welcome/welcome_screen.dart';

class SplashScreenController extends GetxController{
  static SplashScreenController get find => Get.find();

  RxBool animate = false.obs;

  void startAnimation() async{
    await Future.delayed(Duration(milliseconds: 500));
    animate.value = true;
    await Future.delayed(Duration(milliseconds: 5000));
    Get.to(SplashScreenPage());
    animate.value = false;
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()));
  }

  void startAnimations() async{
    await Future.delayed(Duration(milliseconds: 500));
    animate.value = true;
    await Future.delayed(Duration(milliseconds: 5000));
    Get.to(LocationScreen());
    await Future.delayed(Duration(milliseconds: 1000));
    Get.to(OnBoardingScreen());
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()));
  }

  void startAnimationss() async{
    await Future.delayed(Duration(milliseconds: 500));
    animate.value = true;
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()));
  }
}