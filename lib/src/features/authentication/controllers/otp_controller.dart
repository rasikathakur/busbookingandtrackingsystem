import 'package:bustracking/first_page.dart';
import 'package:bustracking/src/repository/authentication_repository/authentication_repository.dart';
import 'package:get/get.dart';

class OTPController extends GetxController{
  static OTPController get instance =>Get.find();

  void verifyotp(String otp) async{
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(FirstPage()):Get.back();
  }

}