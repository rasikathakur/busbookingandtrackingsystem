import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHeaderDrawer extends StatefulWidget{

  @override
  _MyHeaderDrawerState createState()=>_MyHeaderDrawerState();


}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {

  final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final currentUserEmail = currentUser?.email;
    return Container(
      color: Colors.deepPurpleAccent[700],
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/profile.png'),
              )
            ),
          ),
          Text("BOTO",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20
            ),
          ),
          Text( currentUserEmail!,
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14
            ),
          ),
        ],
      ),
    );
  }
}