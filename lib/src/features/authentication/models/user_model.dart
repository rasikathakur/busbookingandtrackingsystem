import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  final String? id;
  final String fullName;
  final String email;
  final String phoneNo;
  final String password;



  UserModel({
    this.id,
    required this.email,
    required this.password,
    required this.fullName,
    required this.phoneNo,
   });

  toJson(){
    return{
      "FullName": fullName,
      "Email": email,
      "Phone": phoneNo,
      "Password": password,

    };
  }


  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return UserModel(
        id: document.id,
        email: data["Email"],
        password: data["Password"],
        fullName: data["FullName"],
        phoneNo: data["Phone"],

    );
  }
}

class PayModel{
  final String? id;
  final String age;
  final String amount;
  final String arrivalt;
  final String departuret;
  final String date;
  final String destination;
  final String source;
  final String gender;
  final String name;
  final String phone;
  final String emails;
  final String seats;
  final Timestamp tt;


  PayModel({
    this.id,
    required this.age,
    required this.amount,
    required this.arrivalt,
    required this.departuret,
    required this.date,
    required this.destination,
    required this.source,
    required this.gender,
    required this.name,
    required this.phone,
    required this.emails,
    required this.seats,
    required this.tt

  });

  toJson(){
    return{
      "Age": age,
      "Amount": amount,
      "ArrivalT": arrivalt,
      "DepartureT": departuret,
      "Date": date,
      "Destination": destination,
      "Source": source,
      "Gender": gender,
      "Name": name,
      "Phone": phone,
      "Email": emails,
      "Seats": seats,
      "tt":tt,
    };
  }


  factory PayModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return PayModel(
      id: document.id,
      age: data["Age"],
      amount: data["Amount"],
      arrivalt: data["ArrivalT"],
      departuret:data["DepartureT"],
      date:data["Date"],
      destination:data["Destination"],
      source:data["Source"],
      gender:data["Gender"],
      name:data["Name"],
      phone:data["Phone"],
      emails:data["Email"],
      seats:data["Seats"],
      tt: data["tt"]
    );
  }
}
