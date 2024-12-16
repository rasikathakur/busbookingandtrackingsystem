import 'package:flutter/material.dart';
class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Center(
        child: Text("Feedback Page"),
      ),
    );
  }
}

class BusBooking extends StatefulWidget {
  @override
  _BusBookingState createState() => _BusBookingState();
}

class _BusBookingState extends State<BusBooking> {
  List<int> _selectedSeats = [];

  List<Seat> _seats = [
    Seat(id: 1, seatNumber: '1', isAvailable: true),
    Seat(id: 2, seatNumber: '2', isAvailable: true),
    Seat(id: 3, seatNumber: '3', isAvailable: false),
    Seat(id: 4, seatNumber: '4', isAvailable: true),
    Seat(id: 5, seatNumber: '5', isAvailable: false),
    Seat(id: 6, seatNumber: '6', isAvailable: true),
    Seat(id: 7, seatNumber: '7', isAvailable: true),
    Seat(id: 8, seatNumber: '8', isAvailable: true),
    Seat(id: 9, seatNumber: '9', isAvailable: true),
    Seat(id: 10, seatNumber: '10', isAvailable: true),
    Seat(id: 11, seatNumber: '11', isAvailable: false),
    Seat(id: 12, seatNumber: '12', isAvailable: true),
    Seat(id: 13, seatNumber: '13', isAvailable: true),
    Seat(id: 14, seatNumber: '14', isAvailable: true),
    Seat(id: 15, seatNumber: '15', isAvailable: true),
    Seat(id: 16, seatNumber: '16', isAvailable: true),
    Seat(id: 17, seatNumber: '17', isAvailable: true),
    Seat(id: 18, seatNumber: '18', isAvailable: false),
    Seat(id: 19, seatNumber: '19', isAvailable: true),
    Seat(id: 20, seatNumber: '20', isAvailable: false),
    Seat(id: 21, seatNumber: '21', isAvailable: true),
    Seat(id: 22, seatNumber: '22', isAvailable: true),
    Seat(id: 23, seatNumber: '23', isAvailable: true),
    Seat(id: 24, seatNumber: '24', isAvailable: true),
    Seat(id: 25, seatNumber: '25', isAvailable: true),
    Seat(id: 26, seatNumber: '26', isAvailable: false),
    Seat(id: 27, seatNumber: '27', isAvailable: true),
    Seat(id: 28, seatNumber: '28', isAvailable: true),
    Seat(id: 29, seatNumber: '29', isAvailable: true),
    Seat(id: 30, seatNumber: '30', isAvailable: true),
  ];

  void _selectSeat(int id) {
    setState(() {
      if (_selectedSeats.contains(id)) {
        _selectedSeats.remove(id);
      } else {
        _selectedSeats.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Bus Ticket Booking'),
    ),
    body: Padding(
    padding: EdgeInsets.all(16.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text(
    'Select your seats:',
    style: TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    ),
    ),
    SizedBox(height: 16.0),
    Expanded(
    child: GridView.count(
    crossAxisCount: 3,
    children: _seats.map((seat) {
    return GestureDetector(
    onTap: seat.isAvailable
    ? () => _selectSeat(seat.id)
        : null,
    child: Container(
    margin: EdgeInsets.all(30),
    decoration: BoxDecoration(
    color: seat.isAvailable
    ? _selectedSeats.contains(seat.id)
    ? Colors.blue
        : Colors.grey[300]
        : Colors.red,
    borderRadius: BorderRadius.circular(8.0),
    ),
    child: Center(
    child: Text(
    seat.seatNumber,
    style: TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
    ),
    );
    }).toList(),
    ),
    ),
    SizedBox(height: 16.0),
    Text(
    'Selected seats: ${_selectedSeats.join(", ")}',
    ),
      SizedBox(height: 16.0),
      ElevatedButton(
        onPressed: () {
          if (_selectedSeats.isEmpty) {
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
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Confirm Seats'),
                  content: Text(
                      'Are you sure you want to book seats ${_selectedSeats.join(", ")}?'),
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
                                  'Your booking has been confirmed for seats ${_selectedSeats.join(", ")}'),
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
                      },
                      child: Text('BOOK'),
                    ),
                  ],
                );
              },
            );
          }
        },
        child: Text('Book Seats'),
      ),
    ],
    ),
    ),
    );
  }
}

class Seat {
  final int id;
  final String seatNumber;
  final bool isAvailable;
  Seat({required this.id, required this.seatNumber, required this.isAvailable});
}