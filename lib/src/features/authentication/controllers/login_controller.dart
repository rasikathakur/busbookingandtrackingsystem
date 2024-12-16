import 'package:bustracking/src/repository/authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  static LoginController get instance =>Get.find();

  var emails = TextEditingController();
  var passwords = TextEditingController();
  var phones = TextEditingController();

  Future<void> loginUser(String email, String password)async{
    await AuthenticationRepository.instance.loginUserWithEmailandPassword(email.toString(), password.toString());
  }

  Future<void> phoneauthentication(String phoneNo) async {
    await AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }
}