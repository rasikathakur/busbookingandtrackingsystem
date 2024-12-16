import 'package:bustracking/src/constants/sizes.dart';
import 'package:bustracking/src/constants/text_strings.dart';
import 'package:bustracking/src/features/authentication/controllers/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/sign_up_controller.dart';

class OTPscreen extends StatelessWidget {

  OTPscreen({Key? key,}) :super(key: key);

  //var controller = Get.put(SignUpController());
  var otpcontroller= Get.put(OTPController());



  @override
  Widget build(BuildContext context) {
    var otp;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(tDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(tOTPtitle, style: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
              fontSize: 80.0,
            ),),
            Text(tOTPsubtitle.toUpperCase(),style: Theme.of(context).textTheme.headline6,),
            SizedBox(
              height: 40.0,
            ),
            Text(tOTPmessage+' @gmail.com',textAlign: TextAlign.center,),
            SizedBox(
              height: 20.0,
            ),
            OtpTextField(
              numberOfFields: 6,
              fillColor: Colors.black87.withOpacity(0.1),
              filled: true,
              onSubmit: (code){
                otp =code;
                print("OTP is $code");
                otpcontroller.verifyotp(otp);
              }

            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: (){
                    OTPController.instance.verifyotp(otp);
              },
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}