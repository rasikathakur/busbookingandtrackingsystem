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

class SplashScreenPage extends StatefulWidget{
  SplashScreenPage({Key? key}):super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {

  final splashScreenController = Get.put(SplashScreenController());

  @override
  void initState(){
    super.initState();
    splashScreenController.startAnimations();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white70,
          child: Stack(
            children: [
              Obx(()=> AnimatedPositioned(
                duration: Duration(milliseconds: 2000),
                top: splashScreenController.animate.value ? 0: -30,
                left: splashScreenController.animate.value ? 50: -30,
                right: splashScreenController.animate.value ? 50: -30,
                bottom: splashScreenController.animate.value ? 50: -30,
                child: const Image(
                      image: AssetImage(tSplashTopIcon),
                  width: 50,
                  height: 50,
              ),
              ),
              ),
              Obx(()=>AnimatedPositioned(
                duration: Duration(milliseconds: 2000),
                bottom: splashScreenController.animate.value ? 200: -30,
                left: splashScreenController.animate.value ? 140: -30,
                right: splashScreenController.animate.value ? 0: -30,
                //right: splashScreenController.animate.value ? 40: -30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tAppName, style: Theme.of(context).textTheme.headline3,),
                    //Text(tAppTagLine, style: Theme.of(context).textTheme.headline2,),
                  ],
                ),
              ),
              ),
              Obx(()=>AnimatedPositioned(
                duration: Duration(milliseconds: 2000),
                bottom: splashScreenController.animate.value ? 150: -30,
                left: splashScreenController.animate.value ? 10: -30,
                right: splashScreenController.animate.value ? 10: -30,
                //right: splashScreenController.animate.value ? 40: -30,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //Text(tAppName, style: Theme.of(context).textTheme.headline3,),
                    Text(tAppTagLine, style: Theme.of(context).textTheme.headline2,textAlign: TextAlign.center,),
                  ],
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