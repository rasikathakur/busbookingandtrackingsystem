import 'dart:async';

import 'package:bustracking/first_page.dart';
import 'package:bustracking/list_of_routes.dart';
import 'package:bustracking/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'choose.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('users');
  String? latitude, longitude;
  var lt = LocationData.lt;
  var lng = LocationData.lng;

  @override
  void initState() {
    super.initState();
    getLocation('2gx0f');
  }

  void getLocation(String userId) {
    final latitudeRef = ref.child('users').child(userId).child('lat');
    final longitudeRef = ref.child('users').child(userId).child('long');

    latitudeRef.once().then((DatabaseEvent snapshot) {
      setState(() {
        latitude = snapshot.snapshot.value.toString();
      });
    }, onError: (Object o) {
      setState(() {
        latitude = 'error';
      });
    });

    longitudeRef.once().then((DatabaseEvent snapshot) {
      setState(() {
        longitude = snapshot.snapshot.value.toString();
      });
    }, onError: (Object o) {
      setState(() {
        longitude = 'error';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: StreamBuilder(
                  stream: ref.onValue,
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (!snapshot.hasData) {
                      return Text('data');
                    } else {
                      print(LocationData.lt);
                      print(LocationData.lng);
                      Map<dynamic, dynamic> map =
                      snapshot.data!.snapshot.value as dynamic;
                      List<dynamic> list = [];
                      list.clear();
                      list = map.values.toList();
                      lt = list[0]['lat'];
                      lng = list[0]['long'];
                      LocationData.lt = lt;
                      LocationData.lng = lng;
                      print('$lt  and $lng');

                      return Container();
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }
}


class LocationData {
  static String? lt;
  static String? lng;
}
