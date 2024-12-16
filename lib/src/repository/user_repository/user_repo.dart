import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/authentication/models/user_model.dart';

class UserRepository extends GetxController{
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async{
    await _db.collection("Users").add(user.toJson())
        .whenComplete(
          () => Get.snackbar("Success", "Your account has been created!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green),
    )
        .catchError((error, stackTrace) {
      Get.snackbar("Error", "Something went wrong. Try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
    }

    Future<UserModel> getUserDetails(String email) async{
     final snapshot = await _db.collection("Users").where("Email", isEqualTo: email).get();
     final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
     return userData;
    }

    Future<List<UserModel>> allUser() async{
     final snapshot = await _db.collection("Users").get();
     final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
     return userData;
    }

  void insertPaymentDatainSubCollection(String email, PayModel payment) async {
    final userDocSnapshot = await _db.collection("Users").where("Email", isEqualTo: email).get();
    final userDoc = userDocSnapshot.docs.single;
    final paymentCollectionRef = userDoc.reference.collection("Payment");
    paymentCollectionRef.add(payment.toJson());
  }
  Future<List<DocumentSnapshot>> retrieveRecentPayments() async {
    QuerySnapshot paymentSnapshot = await _db
        .collection('Users')
        .doc('id')
        .collection('Payment')
        .orderBy('tt', descending: true)
        .limit(1)
        .get();
    return paymentSnapshot.docs;
  }

   /*retrieveRecentpayment() async{
    final userDocSnapshot = await _db.collection("Users").where("Email", isEqualTo: email).get();
    final userDoc = userDocSnapshot.docs.single;
    final paymentCollectionRef = userDoc.reference.collection("Payment");

    final latestPaymentSnapshot = await paymentCollectionRef
        .orderBy("tt", descending: true)
        .limit(1)
        .get();

    final snapshot = await paymentCollectionRef.where("tt", isEqualTo: latestPaymentSnapshot).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }*/


  void deleteRecentPayment(String email) async {
    final userDocSnapshot = await _db.collection("Users").where("Email", isEqualTo: email).get();
    final userDoc = userDocSnapshot.docs.single;
    final paymentCollectionRef = userDoc.reference.collection("Payment");

    final latestPaymentSnapshot = await paymentCollectionRef
        .orderBy("tt", descending: true)
        .limit(1)
        .get();

    print(latestPaymentSnapshot.docs.toString());
    final latestPaymentDoc = latestPaymentSnapshot.docs.single;
    print(latestPaymentDoc);
    final latestPaymentId = latestPaymentDoc.id;

    deletePayment(email, latestPaymentId);
  }
//extra method
  /*det() async{
    final parentDocRef = FirebaseFirestore.instance.collection("Users").doc();
    final subcollectionRef = parentDocRef.collection("Payment");

    final latestSnapshot = await subcollectionRef
        .orderBy("timestamp", descending: true)
        .limit(1)
        .get();

    final latestDoc = latestSnapshot.docs.single;
    final latestDocId = latestDoc.id;
    print(latestDocId);
  }
*/
  void deletePayment(String email, String paymentId) async {
    final userDocSnapshot = await _db.collection("Users").where("Email", isEqualTo: email).get();
    final userDoc = userDocSnapshot.docs.single;
    final paymentCollectionRef = userDoc.reference.collection("Payment");

    await paymentCollectionRef.doc(paymentId).delete();
  }
  /*void deletepayment(String email, String id) async{
    final userDocSnapshot = await _db.collection("Users").where("Email", isEqualTo: email).get();
    final userDoc = userDocSnapshot.docs.single;
    final paymentCollectionRef = userDoc.reference.collection("Payment");
    paymentCollectionRef.doc(id).delete();
  }*/

    //void insertPaymentDatainSubCollection() async{

    //await _db.collection("Users").doc("5t34DOaKNfJyCnU2yOHA").collection("Payment").add({"Age":"19","Amount":"104","ArrivalT":"10:00am","DepartureT":"9:00am","Date":"27/04/23","Destination":"Adgaon","Source":"RK","Gender":"Female","Name":"Rasika","Phone":"8010685987","Email":"rasikathakur303@gmail.com","Seats":"2"});

    //}

  Future<void> updateUserRecord(UserModel user) async{
    await _db.collection("Users").doc(user.id).update(user.toJson());
  }
  }