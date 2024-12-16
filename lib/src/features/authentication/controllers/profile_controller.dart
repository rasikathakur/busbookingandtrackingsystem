import 'package:bustracking/src/repository/user_repository/user_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../repository/authentication_repository/authentication_repository.dart';
import '../models/user_model.dart';

class ProfileController extends GetxController{
  static ProfileController get instace =>Get.find();



  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  getUserData(){
    final email = _authRepo.firebaseUser.value?.email;
    if(email!=null){
      return _userRepo.getUserDetails(email);
    }
    else{
      Get.snackbar("Error", "Login to continue");
    }
  }

  updateRecord(UserModel user) async{
    await _userRepo.updateUserRecord(user);
  }
}