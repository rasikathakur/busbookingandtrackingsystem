import 'package:bustracking/src/features/authentication/models/scedule_model.dart';
import 'package:bustracking/src/repository/schedule_repository/schedule_repo.dart';
import 'package:bustracking/src/repository/user_repository/user_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../repository/authentication_repository/authentication_repository.dart';
import '../models/user_model.dart';

class ScheduleController extends GetxController{
  static ScheduleController get instace =>Get.find();

  final _scheduleRepo = Get.put(ScheduleRepository());

  Future<List<ScheduleModel>> getAllSchedule() async{
    return await _scheduleRepo.allUsers();
  }

}