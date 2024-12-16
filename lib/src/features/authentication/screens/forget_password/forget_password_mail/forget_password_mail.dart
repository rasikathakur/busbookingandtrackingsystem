import 'package:bustracking/src/constants/sizes.dart';
import 'package:bustracking/src/constants/text_strings.dart';
import 'package:bustracking/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../constants/image_string.dart';

class ForgetPasswordMailScreen extends StatelessWidget{
   ForgetPasswordMailScreen({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context){
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(tDefaultSize),
              child: Column(
                children: [
                  SizedBox(
                    height: tDefaultSize*4.0,
                  ),

                Container(
                    width: w,
                    height: h*0.3,
                    decoration: BoxDecoration(
                    image: DecorationImage(
                    image: AssetImage(
                    tForgotPasswordImage,
                    ),
                    fit: BoxFit.cover
                    )
                    ),
               ),
               Container(
                  margin: const EdgeInsets.only(left: 20,right: 20),
                  width: w,
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Text(
                  'Forget Password',
                  style:GoogleFonts.poppins(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  ),
                  ),
                  Text(
                  tForgetPasswordsubTitle,
                  style:TextStyle(
                  fontSize: 20,
                  color: Colors.grey[500],
                  ),
                  ),
                  SizedBox(
                  height: 50,
                  ),
                  ],
              ),
            ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 7,
                                offset: Offset(1,1),
                                color: Colors.grey.withOpacity(0.2),
                              )
                            ]
                        ),

                        child: TextField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email,color:Colors.black87),
                              hintText: 'Email',
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      width:1.0
                                  )
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      width:1.0
                                  )
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              )

                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Container(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: (){
                                Get.to(OTPscreen());
                              },
                              child: Text(
                                  'NEXT',
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
                      ),
                    ],
                  ),
                  ],
                  ),
            ),
          ),
      ),
    );
  }
}