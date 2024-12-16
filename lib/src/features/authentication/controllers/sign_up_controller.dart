import 'package:bustracking/src/features/authentication/models/user_model.dart';
import 'package:bustracking/src/repository/user_repository/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../repository/authentication_repository/authentication_repository.dart';

class SignUpController extends GetxController{
  static SignUpController get instance =>Get.find();

  var emailController = new TextEditingController();
  var passwordController = new TextEditingController();
  var fullnameController = new TextEditingController();
  var phoneNoController = new TextEditingController();

  final userRepo = Get.put(UserRepository());

  Future<void> createrUser(UserModel user) async {
    await userRepo.createUser(user);
    registerUser(user.email, user.password);
  }

  Future<void> registerUser(String email, String password) async {
    await AuthenticationRepository.instance.createUserWithEmailandPassword(email.toString(), password.toString());
  }

}