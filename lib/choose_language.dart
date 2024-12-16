import 'package:bustracking/src/constants/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class ChooseLanguageScreen extends StatefulWidget{
  ChooseLanguageScreen({Key? key}):super(key: key);

  @override
  State<ChooseLanguageScreen> createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Choose Prefered Language"),
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(onPressed: (){
                  },
                    child: Text(
                      "English",
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
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(onPressed: (){
                    context.setLocale(Locale('es','US'));
                  },
                    child: Text(
                      "Hindi",
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
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(onPressed: (){
                    context.setLocale(Locale('en','US'));
                  },
                    child: Text(
                      "Marathi",
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
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
