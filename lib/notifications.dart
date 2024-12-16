import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        width: _isExpanded ? 200.0 : 100.0,
        height: _isExpanded ? 200.0 : 100.0,
        child: Image.network(
          'https://picsum.photos/200',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

/*import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  final List<Bus> _buses = [
    Bus(id: 1, lat: 19.9975, lng: 73.7898, name: 'Nashik - Aurangabad'),
    Bus(id: 2, lat: 18.5204, lng: 73.8567, name: 'Nashik - Pune'),
    Bus(id: 3, lat: 19.0759, lng: 72.8777, name: 'Nashik - Mumbai'),
    Bus(id: 4, lat: 21.1466, lng: 79.0882, name: 'Nashik - Nagpur'),
  ];

  final List<LatLng> _nashikPuneRoute = [
    LatLng(19.9975, 73.7898),
    LatLng(19.9975 - 0.2, 73.7898 + 0.2),
    LatLng(19.9975 - 0.4, 73.7898 + 0.4),
    LatLng(19.9975 - 0.6, 73.7898 + 0.6),
    LatLng(19.9975 - 0.8, 73.7898 + 0.8),
    LatLng(19.9975 - 1.0, 73.7898 + 1.0),
    LatLng(19.9975 - 1.2, 73.7898 + 1.2),
    LatLng(19.9975 - 1.4, 73.7898 + 1.4),
    LatLng(19.9975 - 1.6, 73.7898 + 1.6),
    LatLng(19.9975 - 1.8, 73.7898 + 1.8),
    LatLng(19.9975 - 2.0, 73.7898 + 2.0),
    LatLng(19.9975 - 2.2, 73.7898 + 2.2),
    LatLng(19.9975 - 2.4, 73.7898 + 2.4),
    LatLng(19.9975 - 2.6, 73.7898 + 2.6),
    LatLng(19.9975 - 2.8, 73.7898 + 2.8),
    LatLng(19.9975 - 3.0, 73.7898 + 3.0),
    LatLng(19.9975 - 3.2, 73.7898 + 3.2),
    LatLng(19.9975 - 3.4, 73.7898 + 3.4),
    LatLng(19.9975 - 3.6, 73.7898 + 3.6),
    LatLng(19.9975 - 3.8, 73.7898 + 3.8),
    LatLng(19.9975 - 4.0, 73.7898 + 4.0),
  ];

  LatLng _center = LatLng(19.9975, 73.7898);
  GoogleMapController? _mapController;
  Timer? _timer;
  LatLng? _bus1Location;

  @override
  void initState() {
    super.initState();
    _buses.forEach((bus) {
      _markers.add(Marker(
        markerId: MarkerId(bus.id.toString()),
        position: LatLng(bus.lat, bus.lng),
        infoWindow: InfoWindow(title: bus.name),
      ));
    });

    // Start the timer to update the bus location
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        // Update the location of bus1
        _bus1Location = LatLng(19.9975 - (_timer!.tick * 0.01), 73.7898 + (_timer!.tick * 0.01));
        // Remove the old marker and add a new marker at the updated location
        _markers.removeWhere((marker) => marker.markerId.value == '1');
        _markers.add(Marker(
          markerId: MarkerId('1'),
          position: _bus1Location!,
          infoWindow: InfoWindow(title: 'Nashik - Pune'),
        ));

        // Add polyline for bus 1 from Nashik to Pune
        if (timer.tick == 1) {
          _polylines.add(Polyline(
            polylineId: PolylineId('route'),
            points: _nashikPuneRoute,
            color: Colors.red,
            width: 4,
          ));
        }
      });
    });
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Bus Tracker'),
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _nashikLocation,
            zoom: 9,
          ),
          markers: _markers,
          polylines: _polylines,
        ),
      );
    }
  }*/