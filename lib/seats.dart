import 'package:book_my_seat/book_my_seat.dart';
import 'package:bustracking/passenger.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class SeatsPage extends StatefulWidget {

  @override
  _SeatsPageState createState() => _SeatsPageState();
}

class _SeatsPageState extends State<SeatsPage> {

  List<bool> _selectedSeats = List.generate(30, (_) => false);
  List<String> selectedSeatsIndex = [];
  var numselectedSeats;
  var pricegens;
  var src;
  var des;
  var at, dt, sd;

  @override
  Widget build(BuildContext context) {
    List<Object?> arguments = ModalRoute.of(context)!.settings.arguments as List<Object?>;
    pricegens = arguments[0];
    src=arguments[1] as String;
    des =arguments[2] as String;
    at = arguments[3] as String;
    dt = arguments[4] as String;
    sd = arguments[5] as String;
    print(src);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent.shade700,
        title: Text(
          'Select Seats',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
            color: Colors.white,

          ),
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(

          child: Column(
            children: [
              SizedBox(height: 16.0),
              Container(
                padding: EdgeInsets.all(30.0),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  crossAxisCount: 3,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 120.0,
                  children: List.generate(30, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedSeats[index] = !_selectedSeats[index];
                          if (_selectedSeats[index]) {
                            selectedSeatsIndex.add('Seat ${index+1}');
                          } else {
                            selectedSeatsIndex.remove('Seat ${index-1}');
                          }

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
                          Colors.green
                              : null,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (selectedSeatsIndex.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('No Seats Selected'),
                          content: Text('Please select at least one seat.'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    numselectedSeats = selectedSeatsIndex.length;
                    print(numselectedSeats);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(

                          title: Text('Confirm Seats'),
                          content: Text(
                              'Are you sure you want to book seats\n ${selectedSeatsIndex.join(", ")}?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('CANCEL'),
                            ),
                            TextButton(
                              onPressed: () {
                                // TODO: Add booking logic
                                Navigator.of(context).pop();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Booking Successful'),
                                      content: Text(
                                          'Your booking has been confirmed for seats\n ${selectedSeatsIndex.join(", ")}'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(settings: RouteSettings(arguments: [numselectedSeats,pricegens,src,des, at, dt, sd]),builder: (context) => PassengerDetails()),
                                            );
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text('BOOK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text('Book Seats',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurpleAccent[700],
                  textStyle: TextStyle(
                    color: Colors.black,
                  ),
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(300, 60),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

