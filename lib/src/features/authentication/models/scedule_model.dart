import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleModel{
  final String? id;
  final String price;
  final String arrival;
  final String departure;
  final String source;
  final String destination;
  final String date;
  final GeoPoint src;
  final GeoPoint dst;


  ScheduleModel({
    this.id,
    required this.price,
    required this.arrival,
    required this.departure,
    required this.source,
    required this.destination,
    required this.date,
    required this.src,
    required this.dst,
  });

  toJson(){
    return{
      "Arrival": arrival,
      "Date": date,
      "Departure": departure,
      "Destination": destination,
      "Price": price,
      "Source": source,
      "src": src,
      "dst": dst,
    };
  }

  factory ScheduleModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return ScheduleModel(
      id: document.id,
      arrival: data["Arrival"],
      date: data["Date"],
      departure: data["Departure"],
      destination: data["Destination"],
      price: data["Price"],
      source: data["Source"],
      src: data["src"],
      dst: data["dst"]
    );
  }
}

