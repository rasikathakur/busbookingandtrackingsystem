import 'package:bustracking/src/constants/image_string.dart';
import 'package:bustracking/src/constants/sizes.dart';
import 'package:bustracking/src/constants/text_strings.dart';
import 'package:bustracking/src/features/authentication/controllers/on_boarding_controller.dart';
import 'package:bustracking/src/features/authentication/screens/splash_screen/onboarding_screen/on_boarding_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:bustracking/src/constants/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../models/mode_onboarding.dart';

class OnBoardingScreen extends StatelessWidget{
   OnBoardingScreen({Key? key}): super(key: key);
   final obcontroller = OnBoardingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
            pages: obcontroller.pages,
            liquidController: obcontroller.controller,
            onPageChangeCallback: obcontroller.onPageChangedCallBack,
            slideIconWidget: Icon(Icons.arrow_back_ios),
            enableSideReveal: true,
          ),
          Positioned(
            bottom: 60.0,
            child: OutlinedButton(
              onPressed: (){
                obcontroller.animateToNextSlide();
              },
              style: ElevatedButton.styleFrom(
                side: BorderSide(color: Colors.black26),
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                onPrimary: Colors.white,
              ), child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: tDarkColor,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_forward_ios),
            ),
            ),
          ),
          Positioned(
            top: 30,
            right: 20,
            child: TextButton(
              onPressed: (){
                obcontroller.skip();
              },
              child: Text(
                "SKIP",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            ),
          ),
          Obx(()=> Positioned(
              bottom: 20,
                child: AnimatedSmoothIndicator(
              activeIndex: obcontroller.currentpage.value,
              count: 3,
                  effect: WormEffect(
                    activeDotColor: Color(0xff272727),
                    dotHeight: 5.0,
                  ),
            )),
          )
        ],
      ),
    );
  }
}
