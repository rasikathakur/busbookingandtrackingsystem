import 'package:bustracking/src/constants/colors.dart';
import 'package:bustracking/src/features/authentication/screens/profile/update_profile_screen.dart';
import 'package:bustracking/src/features/authentication/screens/profile/widgets/file_menu.dart';
import 'package:bustracking/src/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../../choose_language.dart';
import '../../../../constants/sizes.dart';
import '../../../../utils/theme/theme.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) :super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}


class _ProfileScreenState extends State<ProfileScreen>
{
  @override
  Widget build(BuildContext context){
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: tPrimaryColor,
        title: Padding(
          padding: const EdgeInsets.only(left: 130),
          child: Text(
            "Profile",
            style: Theme.of(context).textTheme.headline4,
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          IconButton(onPressed: (){
            Get.changeTheme(
              Get.isDarkMode ? TAppTheme.lighttheme : TAppTheme.darktheme,
            );
          }, icon: Icon(Get.isDarkMode ? LineAwesomeIcons.sun: LineAwesomeIcons.moon),),
        ],

      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                        image: AssetImage("assets/myprofiles.jpeg"),
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
                      child: Icon(
                        LineAwesomeIcons.alternate_pencil,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "BOTO",
                  style: GoogleFonts.aclonica(
                    color: tPrimaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
              ),
              Text(
                "rasikathakur303@gmail.com",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                child: ElevatedButton(onPressed: (){
                  Get.to(()=>UpdateProfileScreen());
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
                height: 30,
              ),
              Divider(
                thickness: 0,
              ),
              SizedBox(
                height: 10,
              ),

              ProfileMenuWidget(
                title: "Settings",
                icon: LineAwesomeIcons.cog,
                onPress: (){},
              ),
              ProfileMenuWidget(
                title: "Language",
                icon: LineAwesomeIcons.wallet,
                onPress: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChooseLanguageScreen()));
                },
              ),
              ProfileMenuWidget(
                title: "User Management",
                icon: LineAwesomeIcons.user_check,
                onPress: (){},
              ),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(
                height: 10,
              ),
              ProfileMenuWidget(
                title: "Information",
                icon: LineAwesomeIcons.info,
                onPress: (){},
              ),
              ProfileMenuWidget(
                title: "Logout",
                icon: LineAwesomeIcons.alternate_sign_out,
                textColor: Colors.red,
                endIcon: false,
                onPress: (){
                  AuthenticationRepository.instance.logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

}

