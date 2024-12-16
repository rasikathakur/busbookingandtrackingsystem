import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../features/authentication/models/scedule_model.dart';

class ScheduleRepository extends GetxController{
  static ScheduleRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;


  Future<ScheduleModel> getUserDetailss(String email) async{
    final snapshot = await _db.collection("Schedule").where("Email", isEqualTo: email).get();
    final userDatas = snapshot.docs.map((e) => ScheduleModel.fromSnapshot(e)).single;
    return userDatas;
  }

  Future<List<ScheduleModel>> allUsers() async{
    final snapshot = await _db.collection("Schedule").get();
    final userDatas = snapshot.docs.map((e) => ScheduleModel.fromSnapshot(e)).toList();
    return userDatas;
  }


}
