import 'package:bustracking/login_page.dart';
import 'package:bustracking/src/features/authentication/controllers/sign_up_controller.dart';
import 'package:bustracking/src/features/authentication/models/user_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

   final _formKey= GlobalKey<FormState>();
   /*var emailController = new TextEditingController();
   var passwordController = new TextEditingController();
   var fullnameController = new TextEditingController();
   var phoneNoController = new TextEditingController();*/

  @override
  Widget build(BuildContext context) {
    /*bool loading = false;*/

    List images =[
      "g.png",
      "f.png"
    ];

    //FirebaseAuth _auth = FirebaseAuth.instance;


    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;



    var controller = Get.put(SignUpController());

    void dispose()
    {
      super.dispose();
      controller.emailController.dispose();
      controller.passwordController.dispose();
      controller.fullnameController.dispose();
      controller.phoneNoController.dispose();
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body:GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (){
          },
          child: SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          width: w,
                          height: h*0.20,
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
                                "Get On Board",
                                style:GoogleFonts.poppins(
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold
                                ),

                              ),
                              Text(
                                "Create your account to start your journey with us",
                                style:TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey[500]
                                ),
                              ),
                              SizedBox(
                                height: 30,
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
                                child: GestureDetector(
                                  onTap: (){

                                  },
                                  child: TextFormField(
                                    controller: controller.fullnameController,
                                    //controller: fullnameController,
                                    decoration: InputDecoration(
                                        hintText: 'Name',
                                        prefixIcon: Icon(Icons.person_outline_rounded,color: Colors.deepPurpleAccent,),
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
                                  controller: controller.emailController,
                                  //controller: emailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    } else if (value.trim().isEmail != true) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Email',
                                      prefixIcon: Icon(Icons.email_rounded,color: Colors.deepPurpleAccent,),
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
                                  controller: controller.phoneNoController,
                                  //controller: phoneNoController,
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your phone number';
                                    } else if (value.length != 10) {
                                      return 'Please enter a valid phone number';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Phone No',
                                      prefixIcon: Icon(Icons.numbers,color: Colors.deepPurpleAccent,),
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
                                  controller: controller.passwordController,
                                  //controller: passwordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    } else if (value.length != 6) {
                                      return 'Please enter a valid password';
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: 'Password',
                                      prefixIcon: Icon(Icons.password_rounded,color: Colors.deepPurpleAccent,),
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
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: (){
                            //SignUpController.instance.registerUser(controller.emailController.text.trim(), controller.passwordController.text.trim());
                          },
                          child: Container(
                            width: w*0.5,
                            height: h*0.08,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.deepPurpleAccent,
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
                                  if(_formKey.currentState!.validate()){
                                    final user = UserModel(
                                        email: controller.emailController.text.trim(),
                                        password: controller.passwordController.text.trim(),
                                        fullName: controller.fullnameController.text.trim(),
                                        phoneNo: controller.phoneNoController.text.trim(),
                                    );
                                    SignUpController.instance.createrUser(user);
                                  }
                                },
                                child:
                                 Text(
                                  "Sign Up",
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
                        SizedBox(
                          height: 20,
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Have an account?",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey[500],
                            ),
                            children: [
                              TextSpan(
                                  text: " Login",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ));
                                  },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RichText(text: TextSpan(
                          text: "Sign Up using",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 20,
                          ),
                        )
                        ),
                        Wrap(
                          children: List<Widget>.generate(
                            2,
                              (index){
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                radius: 25,
                                backgroundImage: AssetImage(
                                  "assets/"+images[index],
                                ),
                                ),
                                ),
                              );
                            }
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ),
        )
    );
  }
}