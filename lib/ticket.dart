import 'package:bustracking/first_page.dart';
import 'package:bustracking/src/repository/user_repository/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'dart:math' as math;
import 'package:get/get.dart';

class TicketScreen extends StatefulWidget {
  TicketScreen({Key? key}): super(key: key);
  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {

  final controller = Get.put(UserRepository());
  var pricegen, arrivaltime, departuretime, scheddate;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20,left: 10,bottom: 20),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: (){
                          Get.to(FirstPage());
                        },
                        icon: Icon(
                          Icons.close,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Your Ticket Details",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder(
                future: controller.retrieveRecentPayments(),
                builder: (context, snapshot){
                  if(snapshot.connectionState==ConnectionState.done){
                    if(snapshot.hasData){
                      /*ScheduleModel sched = snapshot.data as ScheduleModel;
                final id =TextEditingController(text: sched.id);
                final source = TextEditingController(text: sched.source);
                final destination = TextEditingController(text: sched.destination);
                final arrival = TextEditingController(text: sched.arrival);
                final departure = TextEditingController(text: sched.departure);
                final price = TextEditingController(text: sched.price);
                final date = TextEditingController(text: sched.date);*/
                      /*var filteredSchedules = snapshot.data!.where((schedule) =>
                schedule.source == source && schedule.destination == destination
                ).toList();*/
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return  Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10),
                            child: Center(
                              child: TicketWidget(
                                width: 400,
                                height: 600,
                                isCornerRounded: true,
                                child: Column(
                                  children: [
                                    Container(
                                      width: 400,
                                      height: 300,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.deepPurpleAccent,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:EdgeInsets.symmetric(horizontal:10,vertical: 10),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    child: Text(
                                                      "9 May 2023",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),

                                                  Container(
                                                    child: Text(
                                                      "       BOTO\nAt Your Service",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                              child: Divider(
                                                thickness: 1,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Container(
                                              child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            "RK",
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w900,
                                                              fontSize: 30,
                                                            ),
                                                          ),
                                                          Text(
                                                            "8:00am",
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w900,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            "Adgaon",
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w900,
                                                              fontSize: 30,
                                                            ),
                                                          ),
                                                          Text(
                                                            "7:00 am",
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w900,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ) ,
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                              child: Divider(
                                                thickness: 1,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 200),
                                                  child: Container(
                                                      width: 170,
                                                      height: 100,
                                                      child: Transform(
                                                        transform: Matrix4.rotationY(math.pi),
                                                        child: Image(
                                                          image: AssetImage(
                                                            "assets/busmove.gif",
                                                          ),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      )
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 400,
                                      height: 250,
                                      color: Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Seat No",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  "Seat 1\nSeat 2\n ",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 100,
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                              child: Divider(
                                                thickness: 1,
                                                color: Colors.deepPurpleAccent,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Ticket Id",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  "1m8DoFVSB7Aqzr9eQ9C3",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 100,
                                                ),

                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                              child: Divider(
                                                thickness: 1,
                                                color: Colors.deepPurpleAccent,
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Fare",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  "Rs.56",
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                  ),
                                                ),

                                                Padding(
                                                  padding: const EdgeInsets.only(left: 0),
                                                  child: Container(
                                                    width: 100,
                                                    height: 100,
                                                    child: Image(
                                                      image: AssetImage(
                                                        "assets/qr.png",
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          );

                        },
                      );
                    }
                    else if(snapshot.hasError){
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }
                    else{
                      return Center(
                        child: Text("Something went wrong"),
                      );
                    }
                  }
                  else{
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
