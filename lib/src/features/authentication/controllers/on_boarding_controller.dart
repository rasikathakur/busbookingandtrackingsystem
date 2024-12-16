import 'package:bustracking/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';
import '../../../constants/colors.dart';
import '../../../constants/image_string.dart';
import '../../../constants/text_strings.dart';
import '../models/mode_onboarding.dart';
import '../screens/splash_screen/onboarding_screen/on_boarding_widget.dart';

class OnBoardingController extends GetxController{
  final controller = LiquidController();
  RxInt currentpage = 0.obs;

  final pages = [
    OnBoardingPageWidget(model: onBoardingmodel(
      image: tOnBoardingImage1,
      title: onBoardingTitle1,
      subTitle: onBoardingsubTitle1,
      counterText: onBoardingCounter1,
      bgColor: tOnBoardingPage1Color,
    ),
    ),

    OnBoardingPageWidget(model: onBoardingmodel(
      image: tOnBoardingImage2,
      title: onBoardingTitle2,
      subTitle: onBoardingsubTitle2,
      counterText: onBoardingCounter2,
      bgColor: tOnBoardingPage2Color,
    ),
    ),

    OnBoardingPageWidget(model: onBoardingmodel(
      image: tOnBoardingImage3,
      title: onBoardingTitle3,
      subTitle: onBoardingsubTitle3,
      counterText: onBoardingCounter3,
      bgColor: tOnBoardingPage3Color,
    ),
    ),
  ];

  onPageChangedCallBack(int activePageIndex) {
    currentpage.value = activePageIndex;
  }
  animateToNextSlide(){
    int nextpage = controller.currentPage+1;
    controller.animateToPage(page: nextpage);
  }
  skip()=>Get.to(WelcomeScreen());
}