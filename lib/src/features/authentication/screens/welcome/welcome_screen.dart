import 'package:bustracking/login_page.dart';
import 'package:bustracking/signin_page.dart';
import 'package:bustracking/src/constants/colors.dart';
import 'package:bustracking/src/constants/image_string.dart';
import 'package:bustracking/src/constants/sizes.dart';
import 'package:bustracking/src/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/splash_screen_controller.dart';

class WelcomeScreen extends StatefulWidget{
  const WelcomeScreen({Key? key}):super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  final splashScreenController = Get.put(SplashScreenController());


  @override
  Widget build(BuildContext context){
    splashScreenController.startAnimationss();
    var mediaQuery = MediaQuery.of(context);
    var height = MediaQuery.of(context).size.height;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? tSecondaryColor : tPrimaryColor,
      body: Stack(
        children: [
          Obx(()=>AnimatedPositioned(
              duration: Duration(milliseconds: 1200),
              bottom: splashScreenController.animate.value ? 0: -100,
              left: splashScreenController.animate.value ? 0: 0,
              right: splashScreenController.animate.value ? 0: 0,
              top: splashScreenController.animate.value ? 0: 0,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 2000),
                opacity: splashScreenController.animate.value ? 1:0,
                child: Container(
                  padding: EdgeInsets.all(tDefaultSize),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(
                        image: AssetImage(tWelcomeScreenImage),
                        height: height*0.6,
                      ),
                      Column(
                        children: [
                          Text(tWelcomeTitle, style: Theme.of(context).textTheme.headline4,),
                          Text(tWelcomeSubtitle, style: Theme.of(context).textTheme.headline6,textAlign: TextAlign.center,),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: (){
                                Get.to(LoginPage());
                              },
                              child: Text(
                                tLogin.toUpperCase(),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: ElevatedButton
                              (onPressed: (){
                                Get.to(SignUpPage());
                            },
                              child: Text(
                                tSignUp.toUpperCase(),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}