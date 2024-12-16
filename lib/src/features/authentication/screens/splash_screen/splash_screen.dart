import 'package:bustracking/src/constants/colors.dart';
import 'package:bustracking/src/constants/image_string.dart';
import 'package:bustracking/src/constants/sizes.dart';
import 'package:bustracking/src/constants/text_strings.dart';
import 'package:bustracking/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:bustracking/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:bustracking/src/features/authentication/controllers/splash_screen_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatefulWidget{
  SplashScreen({Key? key}):super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final splashScreenController = Get.put(SplashScreenController());

  @override
  Widget build(BuildContext context){
    splashScreenController.startAnimation();
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white70,
          child: Stack(
            children: [
               Obx(()=> AnimatedPositioned(
                  duration: Duration(milliseconds: 1600),
                  top: splashScreenController.animate.value ? 10: -30,
                    left: splashScreenController.animate.value ? 10: -30,
                  child: Container(
                    width: tSplashContainerSize,
                    height: tSplashContainerSize,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: tPrimaryColor,
                    ),
                  ),
                    /*child: Image(
                      image: AssetImage(tSplashTopIcon),
                      width: 100,
                      height: 100,
              ),*/
              ),
               ),
              Obx(()=>AnimatedPositioned(
                  duration: Duration(milliseconds: 1600),
                  top: splashScreenController.animate.value ? 40: -30,
                  left: splashScreenController.animate.value ? 10: -30,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: tPrimaryColor,
                    ),
                  ),
                ),
              ),
              Obx(()=> AnimatedPositioned(
                  duration: Duration(milliseconds: 1600),
                  top: splashScreenController.animate.value ? 10: -30,
                  left: splashScreenController.animate.value ? 100: -30,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: tPrimaryColor,
                    ),
                  ),
                ),
              ),
               Container(
                 child: Obx(()=>AnimatedPositioned(
                     duration: Duration(milliseconds: 2400),
                    top: splashScreenController.animate.value ? 300: -150,
                    right: splashScreenController.animate.value ? 0: -300,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 2000),
                      opacity: splashScreenController.animate.value ? 1:0,
                      child: Image(
                        image: AssetImage(tSplashImage),
                        fit: BoxFit.cover,
                        width: 400,
                        height: 250,
                      ),
                    ),
              ),
                 ),
               ),
              Obx(()=> AnimatedPositioned(
                  duration: Duration(milliseconds: 2400),
                    bottom: splashScreenController.animate.value ? 60: -30,
                    right: splashScreenController.animate.value ? tDefaultSize: -30,
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 2000),
                      opacity: splashScreenController.animate.value ? 1:0,
                      child: Container(
                        width: tSplashContainerSize,
                        height: tSplashContainerSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: tPrimaryColor,
                        ),
                      ),
                    ),
                ),
              ),
              Obx(()=> AnimatedPositioned(
                  duration: Duration(milliseconds: 2400),
                  bottom: splashScreenController.animate.value? 60:0,
                  right: splashScreenController.animate.value ? 50:0,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: tPrimaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}