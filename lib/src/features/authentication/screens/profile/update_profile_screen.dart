import 'package:bustracking/src/features/authentication/models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../controllers/profile_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class UpdateProfileScreen extends StatefulWidget{
UpdateProfileScreen({Key? key}):super(key: key);

@override
State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

late final controller;
 var userd;
 File? pickedImage;


void imagePickerOption() {
  Get.bottomSheet(
    SingleChildScrollView(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        child: Container(
          color: Colors.white,
          height: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Pic Image From",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    pickImage(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera),
                  label: const Text("CAMERA"),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.image),
                  label: const Text("GALLERY"),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close),
                  label: const Text("CANCEL"),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

pickImage(ImageSource imageType) async {
  try {
    final photo = await ImagePicker().pickImage(source: imageType);
    if (photo == null) return;
    final tempImage = File(photo.path);
    setState(() {
      pickedImage = tempImage;
    });

    Get.back();
  } catch (error) {
    debugPrint(error.toString());
  }
}



@override
    void initState(){
     controller = Get.put(ProfileController());
    userd = controller.getUserData();
    super.initState();
    }

  @override
  Widget build(BuildContext context) {
    //final controller = Get.put(ProfileController());
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tPrimaryColor,
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text("Profile", style: Theme.of(context).textTheme.headline4),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(isDark? LineAwesomeIcons.sun: LineAwesomeIcons.moon),),
        ],

      ),

      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(tDefaultSize),
          child: FutureBuilder(
            future: userd,
            builder: (context, snapshot){
              if(snapshot.connectionState==ConnectionState.done){
                if(snapshot.hasData){
                  UserModel user = snapshot.data as UserModel;
                  final id =TextEditingController(text: user.id);
                  final email = TextEditingController(text: user.email);
                  final password = TextEditingController(text: user.password);
                  final fullName = TextEditingController(text: user.fullName);
                  final phoneNo = TextEditingController(text: user.phoneNo);

                  return Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: pickedImage != null
                                  ? Image.file(
                                pickedImage!,
                                width: 170,
                                height: 170,
                                fit: BoxFit.cover,
                              )
                                  : Image(
                                image: AssetImage("assets/profile.png"),
                                width: 170,
                                height: 170,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: tPrimaryColor,
                              ),
                              child: IconButton(
                                icon: Icon(
                                  LineAwesomeIcons.camera,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                onPressed: imagePickerOption,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Form(
                          child: Column(
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
                                  child: TextFormField(
                                    //initialValue: userData.fullName,
                                    controller: fullName,
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
                                        ),
                                    ),
                                  ),
                              ),
                              SizedBox(
                                height: 40,
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
                                  //initialValue: userData.email,
                                  controller: email,
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
                                height: 40,
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
                                  //initialValue: userData.phoneNo,
                                  controller: phoneNo,
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
                                height: 40,
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
                                  //initialValue: userData.password,
                                  controller: password,
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
                              SizedBox(
                                height: 40,
                              ),

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(onPressed: () async{
                                 final userdata = UserModel(
                                     id: id.text,
                                     email: email.text.trim(),
                                     password: password.text.trim(),
                                     fullName: fullName.text.trim(),
                                     phoneNo: phoneNo.text.trim()
                                 );
                                 await controller.updateRecord(userdata);
                                },
                                  child: Text(
                                    "Edit Profile",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: tPrimaryColor,
                                    side: BorderSide.none,
                                    shape: StadiumBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          )
                      ),
                    ],
                  );
                }
                else if(snapshot.hasError){
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                else{
                  return Center(
                    child: Text("Something went wrong"),
                  );
                }
              }
              else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),

    );
  }
}
