import 'package:book_my_seat/book_my_seat.dart';
import 'package:bustracking/nav.dart';
import 'package:bustracking/seats.dart';
import 'package:bustracking/src/features/authentication/controllers/schedule_model.dart';
import 'package:bustracking/src/features/authentication/models/scedule_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'navigation_screen.dart';


class ListRoutePage extends StatefulWidget {
  @override
  _ListRoutePageState createState() => _ListRoutePageState();
}

class _ListRoutePageState extends State<ListRoutePage> {

  List<bool> _selectedSeats = List.generate(30, (_) => false);

  final controller = Get.put(ScheduleController());
  var pricegen, arrivaltime, departuretime, scheddate;
  late LatLng se;
  late LatLng de;
  String lat = LocationData.lt as String;
  String lng = LocationData.lng as String;
  late double lt;
  late double long;

  @override
  Widget build(BuildContext context) {
    lt = double.parse(lat);
    long = double.parse(lng);
    print(lt);

    // Filter the schedules list based on source and destination
    //var filteredSchedules = widget.schedules.where((schedule) =>
    //schedule.source == source && schedule.destination == destination).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          'Bus Schedules',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(settings:RouteSettings(arguments: [pricegen,arrivaltime,departuretime,scheddate]),builder: (context)=>SeatsPage()));
          /*showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(70.0),
            ),
            builder: (context) => SeatsPage(),
            /*SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Text(
                      'Select Seat',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    GridView.count(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      crossAxisCount: 3,
                      childAspectRatio: 0.8,
                      mainAxisSpacing: 8.0,
                      crossAxisSpacing: 8.0,
                      children: List.generate(30, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedSeats[index] = !_selectedSeats[index];
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Image(
                          image: AssetImage(_selectedSeats[index] ? 'assets/chaird.png' : 'assets/chair.png'),
                              fit: BoxFit.contain,
                              color: _selectedSeats[index]?
                              Colors.black
                                  : null,
                        ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        // Do something when the button is pressed
                      },
                      child: Text(
                        'Book Seat',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),*/
          );*/
        },
        child: FutureBuilder(
          future: controller.getAllSchedule(),
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
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    pricegen = int.parse(snapshot.data![index].price);
                    arrivaltime = snapshot.data![index].arrival;
                    departuretime = snapshot.data![index].departure;
                    scheddate = snapshot.data![index].date;
                    se = LatLng(
                        snapshot.data![index].src.latitude,
                        snapshot.data![index].src.longitude);
                    de = LatLng(
                        snapshot.data![index].dst.latitude,
                        snapshot.data![index].dst.longitude);
                    print(se);
                    print(de);
                    print(pricegen);
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ListTile(
                            tileColor: Colors.deepPurpleAccent.withOpacity(0.1),
                            leading: IconButton(
                              icon: Icon(LineAwesomeIcons.search_location),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder:(context)=> NavigationScreen(
                                  se.latitude,
                                  se.longitude,
                                  de.latitude,
                                  de.longitude,
                                  lt,
                                  long,
                                )));
                              },
                            ),
                            title: Text(
                              '${snapshot.data![index].source} - ${snapshot.data![index].destination}',/*${filteredSchedules[index].source}${filteredSchedules[index].destination}'*/
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            subtitle: Column(
                              children: [
                                SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    Text(
                                      'Departure: ${snapshot.data![index].departure}'/*${filteredSchedules[index].departureTime}*/,
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    SizedBox(width: 16.0),
                                    Text(
                                      'Arrival: ${snapshot.data![index].arrival}'/*${filteredSchedules[index].arrivalTime}*/,
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                Divider(
                                  thickness: 1,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Price: ${snapshot.data![index].price}'/*${filteredSchedules[index].price}'*/,
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    Text(
                                      '${snapshot.data![index].date}'/*'${filteredSchedules[index].date}'*/,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            width: double.infinity,
                            height: 10,
                          ),
                        ],
                      ),

                      /*Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${snapshot.data![index].source} - ${snapshot.data![index].destination}',/*${filteredSchedules[index].source}${filteredSchedules[index].destination}'*/
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(

                                      '',
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Row(
                                      children: [
                                        Text(
                                          'Departure: ${snapshot.data![index].departure}'/*${filteredSchedules[index].departureTime}*/,
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                        SizedBox(width: 16.0),
                                        Text(
                                          'Arrival: ${snapshot.data![index].arrival}'/*${filteredSchedules[index].arrivalTime}*/,
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8.0),
                                    Divider(
                                      thickness: 1,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Price: ${snapshot.data![index].price}'/*${filteredSchedules[index].price}'*/,
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                        Text(
                                          '${snapshot.data![index].date}'/*'${filteredSchedules[index].date}'*/,
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),*/

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
      ),
    );
  }
}

