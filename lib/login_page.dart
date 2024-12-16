import 'package:bustracking/first_page.dart';
import 'package:bustracking/signin_page.dart';
import 'package:bustracking/src/constants/sizes.dart';
import 'package:bustracking/src/constants/text_strings.dart';
import 'package:bustracking/src/features/authentication/controllers/login_controller.dart';
import 'package:bustracking/src/features/authentication/screens/forget_password/forget_password_mail/forget_password_mail.dart';
import 'package:bustracking/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bustracking/src/features/authentication/controllers/sign_up_controller.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey= GlobalKey<FormState>();

  /*@override
  void initState(){
    _formKeys = GlobalKey<FormState>();
  }*/

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(LoginController());

    void dispose()
    {
      super.dispose();
      controller.emails.dispose();
      controller.passwords.dispose();
    }

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body:SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                width: w,
                height: h*0.3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/signupsss.png"
                    ),
                    fit: BoxFit.cover
                  )
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20,right: 20),
                width: w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back",
                        style:GoogleFonts.poppins(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),

                      ),
                      Text(
                        "Sign into your account",
                        style:TextStyle(
                            fontSize: 20,
                            color: Colors.grey[500]
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),

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

                        child: TextFormField(
                          controller: controller.emails,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email,color:Colors.deepPurpleAccent),
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
                        height: 20,
                      ),
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
                        child: TextFormField(
                          controller: controller.passwords,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              prefixIcon: Icon(Icons.password,color:Colors.deepPurpleAccent),
                              suffixIcon: Icon(Icons.remove_red_eye_sharp, color: Colors.deepPurpleAccent,),
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
                        height: 20,
                      ),
                      Row(
                      children: [
                        Expanded(child: Container(),),
                        TextButton(
                          onPressed: (){
                            showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                                builder: (context)=>SingleChildScrollView(
                                  child: Container(
                                    padding: EdgeInsets.all(30.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(tForgetPasswordTitle,style: Theme.of(context).textTheme.headline5,),
                                        Text(tForgetPasswordsubTitle,style: Theme.of(context).textTheme.bodyText2,),
                                        const SizedBox(
                                          height: 30.0,
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.pop(context);
                                            Get.to(ForgetPasswordMailScreen());
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(20.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Colors.deepPurpleAccent.shade200,
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(Icons.mail_outline_outlined, size: 60.0,),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('E-mail',style: Theme.of(context).textTheme.headline5,),
                                                    Text(tResetviaEmail,style: Theme.of(context).textTheme.bodyText2,),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 40.0,
                                        ),
                                        GestureDetector(
                                          onTap: (){},
                                          child: Container(
                                            padding: EdgeInsets.all(20.0),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10.0),
                                              color: Colors.deepPurpleAccent.shade200,
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(Icons.mobile_friendly_outlined, size: 60.0,),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Phone No',style: Theme.of(context).textTheme.headline5,),
                                                    Text(tResetviaPhone,style: Theme.of(context).textTheme.bodyText2,),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            );
                          },
                          child: Text(
                            "Forgot your Password?",
                            style:TextStyle(
                                fontSize: 20,
                                color: Colors.blue[500]
                            ),
                          ),
                        ),
                      ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 170,bottom: 20),
                        child: Text(
                          "or",
                          style:TextStyle(
                              fontSize: 20,
                              color: Colors.grey[500]
                          ),
                        ),
                      ),
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
                        child: TextFormField(
                          controller: controller.phones,
                          decoration: InputDecoration(
                              hintText: 'Phone No',
                              prefixIcon: Icon(Icons.numbers,color:Colors.deepPurpleAccent),
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
                              ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 70),
                        child: GestureDetector(
                          onTap: (){

                            //LoginController.instance.loginUser(controller.emails.text.trim(), controller.passwords.text.trim());


                          },
                          child: Container(
                            width: w*0.5,
                            height: h*0.08,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/loginbtns.png"
                                    ),
                                    fit: BoxFit.cover
                                ),
                            ),
                            child: Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  side: BorderSide(color: Colors.deepPurpleAccent),
                                ),
                                onPressed: (){
                                  if(controller.emails.value!=null && controller.passwords.value!=null){
                                    if(_formKey.currentState!.validate()){
                                      LoginController.instance.loginUser(controller.emails.text.trim(), controller.passwords.text.trim());
                                    }
                                  }
                                   else if(controller.phones.value!=null){
                                      if(_formKey.currentState!.validate()){
                                        LoginController.instance.phoneauthentication(controller.phones.text.trim());
                                        Get.to(()=> OTPscreen());
                                      }
                                    }
                                 else if(controller.phones.value==null && controller.emails.value==null && controller.passwords.value==null){
                                    AlertDialog(
                                      title: Text(
                                        'Error',
                                        textAlign: TextAlign.start,
                                      ),
                                      content: Text('Enter email and password or log in with your phone number'),
                                      actions: <Widget>[
                                        TextButton(
                                            child: Text('OK'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            }
                                        ),
                                      ],
                                    );
                                  }
                                 else if(controller.phones.value!=null && controller.emails.value!=null && controller.passwords.value!=null){
                                    AlertDialog(
                                      title: Text(
                                        'Error',
                                        textAlign: TextAlign.start,
                                      ),
                                      content: Text('Cant login with both email and phone...choose either one'),
                                      actions: <Widget>[
                                        TextButton(
                                            child: Text('OK'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            }

                                        ),
                                      ],
                                    );
                                  }
                                },
                                child: Text(
                                  "Login",
                                  style:TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),

                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
              ),
              SizedBox(
                height: w*0.09,
              ),
              RichText(text: TextSpan(
                  text: "Don\'t have an account?",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                    text: " Create",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignUpPage(),
                        ));
                      },
                  ),
                ],
              )
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      )
    );
  }
}
