import 'package:bustracking/pay.dart';
import 'package:bustracking/src/features/authentication/controllers/schedule_model.dart';
import 'package:bustracking/src/features/authentication/models/scedule_model.dart';
import 'package:bustracking/src/features/authentication/models/user_model.dart';
import 'package:bustracking/src/repository/schedule_repository/schedule_repo.dart';
import 'package:bustracking/src/repository/user_repository/user_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'choose.dart';

class PassengerDetails extends StatefulWidget {
  PassengerDetails({Key? key}) : super(key: key);
  @override
  _PassengerDetailsState createState() => _PassengerDetailsState();
}

class _PassengerDetailsState extends State<PassengerDetails> {

  //final controller = Get.put(ScheduleController());
  //final controller = new ChoosePage();
   var emailss = new TextEditingController();
   var age = new TextEditingController();
   var namess = new TextEditingController();
   var phoness = new TextEditingController();

  final _formKey = GlobalKey<FormState>();
  String _selectedGender = '';
  String? _email;
  String? _phoneNumber;
  String? _passengerName;
  int? _passengerAge;
  var numseats;
  var price;
  var tot;
  var sc;
  var ds;
  var arrt, dept, sdate;
  final userRepo = Get.put(UserRepository());
  final currentUser = FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    final currentUserEmail = currentUser?.email;
    //price = controller.;
    List<Object?> argument = ModalRoute.of(context)!.settings.arguments as List<Object?>;
    numseats = argument[0];
    price = argument[1];
    sc = argument[2] as String;
    ds = argument[3] as String;
    arrt = argument[4] as String;
    dept = argument[5] as String;
    sdate = argument[6] as String;
    print(sc);
    print(ds);
    tot = price*numseats;
    var totamt = tot.toString();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          '$sc-$ds',
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.start,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                SizedBox(height: 20),
                Text(
                  "Contact Information",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: emailss,
                  decoration: InputDecoration(
                    hintText: "Enter your email here",
                    labelText: "Email Id",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: phoness,
                  decoration: InputDecoration(
                    hintText: "Enter your phone number here",
                    labelText: "Phone No",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    } else if (value.length != 10) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _phoneNumber = value;
                  },
                ),


                SizedBox(height: 20),
                Divider(
                  thickness: 1,
                  color: Colors.deepPurpleAccent.shade700,
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Text(
                      "Passenger Details for Passenger",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: namess,
                      decoration: InputDecoration(
                        hintText: "Enter passenger name",
                        labelText: "Passenger Name",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter passenger name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _passengerName = value;
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'Gender: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: RadioListTile(
                            title: Text('Male'),
                            value: 'male',
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value.toString();
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            title: Text('Female'),
                            value: 'female',
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value.toString();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: age,
                      decoration: InputDecoration(
                        hintText: "Enter passenger age",
                        labelText: "Passenger Age",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter passenger age';
                        } else if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _passengerAge = int.tryParse(value!);
                      },
                    ),

                    SizedBox(height: 20),
                    Divider(
                      thickness: 1,
                      color: Colors.deepPurpleAccent.shade700,
                    ),
                    SizedBox(height: 40),
                    Text(
                      "Total Seats:  $numseats",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                /*Text(
                  "Passenger Details for passenger 1",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter passenger name",
                    labelText: "Passenger Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter passenger name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _passengerName = value;
                  },
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'Gender: ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: RadioListTile(
                        title: Text('Male'),
                        value: 'male',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value.toString();
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: Text('Female'),
                        value: 'female',
                        groupValue: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value.toString();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter passenger age",
                    labelText: "Passenger Age",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter passenger age';
                    } else if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _passengerAge = int.tryParse(value!);
                  },
                ),
                SizedBox(height: 20),*/
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.grey[200],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text( "$tot",
                style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
          ),
           ),
            ),
            ElevatedButton(
              onPressed: () async{
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // do something with form data
                  print('Name: $_passengerName');
                  print('Email: $_email');
                  print('Phone Number: $_phoneNumber');
                  print('Gender: $_selectedGender');
                  print('Age: $_passengerAge');
                  print('Total Seats: $numseats');


                  // Extract schedule data from snapshot
                  //final data = snapshot.data() as Map<String, dynamic>;
                      //.where('source', isEqualTo: 'RK')
                     // .where('destination', isEqualTo: 'adgaon')


                  // Extract schedule data from snapshot
                  //final data = snapshot.docs.map((doc) => ScheduleModel.fromSnapshot(doc)).toList();
                  //final schedule = data[0];


                  final payment = PayModel(
                      age: age.text.trim(),
                      amount: tot.toString(),
                      arrivalt: arrt,
                      departuret: dept,
                      date: sdate,
                      destination: sc,
                      source: ds,
                      gender: _selectedGender,
                      name: namess.text.trim(),
                      phone: phoness.text.trim(),
                      emails: emailss.text.trim(),
                      seats: numseats.toString(),
                      tt: Timestamp.now(),
                  );

                  userRepo.insertPaymentDatainSubCollection(currentUserEmail!, payment);
                    //userRepo.deleteRecentPayment(currentUserEmail!);
                  Navigator.push(context, MaterialPageRoute(settings:RouteSettings(arguments: [tot]),builder: (context) => PayScreen()));
                }
              },
              child: Text(
                'Proceed',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurpleAccent[700],
                textStyle: TextStyle(
                  color: Colors.black,
                ),
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                minimumSize: Size(250, 60),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
