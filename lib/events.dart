import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}


class _EventsPageState extends State<EventsPage> {
  int _currentPolylineIndex = 0;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  final List<Bus> _buses = [
    Bus(id: 1, lat: 19.99298051806986, lng: 73.78634298686839, name: 'Nashik - Pune'),
    Bus(id: 2, lat: 18.5204, lng: 73.8567, name: 'Nashik - Aurangabad'),
    Bus(id: 3, lat: 19.0759, lng: 72.8777, name: 'Nashik - Mumbai'),
    Bus(id: 4, lat: 21.1466, lng: 79.0882, name: 'Nashik - Nagpur'),
  ];

  List<ExtendedLatLng> _nashikPuneRoute = [];

  ExtendedLatLng _center = ExtendedLatLng(19.99321055527898, 73.78737127646485);
  GoogleMapController? _mapController;
  Timer? _timer;
  ExtendedLatLng? _bus1Location;

  @override
  void initState() {
    _nashikPuneRoute = [
      ExtendedLatLng(19.99321055527898, 73.78737127646485),
      ExtendedLatLng(19.954489986965083, 73.83955633037567),
      ExtendedLatLng(19.91059518901223, 73.89723454785607),
      ExtendedLatLng(19.920754555206962, 73.88698562671536),
      ExtendedLatLng(19.864516499390472, 73.9578675323148),
      ExtendedLatLng(19.822845815186398, 73.99995366376444),
      ExtendedLatLng(19.787417141033053, 74.06640545026389),
      ExtendedLatLng(19.745726255863488, 74.1151367603635),
      ExtendedLatLng(19.712365704521623, 74.14393253451327),
      ExtendedLatLng(19.653967995550165, 74.15943795136313),
      ExtendedLatLng(19.59972250921011, 74.18380360641294),
      ExtendedLatLng(19.512056559881295, 74.19487890416285),
      ExtendedLatLng(19.47029414367983, 74.20595420191275),
      ExtendedLatLng(19.445231525763916, 74.19044878506288),
      ExtendedLatLng(19.411808681019323, 74.20595420191275),
      ExtendedLatLng(19.321950763008218, 74.17715842776299),
      ExtendedLatLng(19.311498955576106, 74.17272830866303),
      ExtendedLatLng(19.275957814333754, 74.1505777131632),
      ExtendedLatLng(19.23622623675534, 74.13064217721337),
      ExtendedLatLng(19.19439313493168, 74.10627652216358),
      ExtendedLatLng(19.167195914129728, 74.053115092964),
      ExtendedLatLng(19.169288167450404, 74.06640545026389),
      ExtendedLatLng(19.152549397416195, 74.03096449746418),
      ExtendedLatLng(19.127438057935244, 73.98666330646455),
      ExtendedLatLng(19.091857126453306, 73.96229765141476),
      ExtendedLatLng(19.043706045704607, 73.96008259186476),
      ExtendedLatLng(19.026954567048552, 73.9423621154649),
      ExtendedLatLng(19.0181499635469, 73.94456257229027),
      ExtendedLatLng(18.98450780613343, 73.93185509847322),
      ExtendedLatLng(18.926819728312847, 73.9216891194196),
      ExtendedLatLng(18.902777146047605, 73.91406463512938),
      ExtendedLatLng(18.878731108570705, 73.89881566654894),
      ExtendedLatLng(18.87151662412032, 73.89627417178554),
      ExtendedLatLng(18.847466100459034, 73.88102520320508),
      ExtendedLatLng(18.816195267582323, 73.87594221367827),
      ExtendedLatLng(18.7704812820115, 73.85306876080762),
      ExtendedLatLng(18.610790026796447, 73.8190881741729),
      ExtendedLatLng(18.58015057860218, 73.83165983639546),
      ExtendedLatLng(18.523963955096594, 73.85500720909451),
    ];
    Polyline polyline = Polyline(
      polylineId: PolylineId('polyline'),
      color: Colors.red,
      width: 5,
      points: _nashikPuneRoute,
    );
    _polylines.add(polyline);
    super.initState();
    _buses.forEach((bus) {
      _markers.add(Marker(
        markerId: MarkerId(bus.id.toString()),
        position: LatLng(bus.lat, bus.lng),
        infoWindow: InfoWindow(title: bus.name),
      ));
    });

    // Start the timer to update the bus location
    _timer = Timer.periodic(Duration(microseconds: 5), (timer) {
      setState(() {
        // Update the location of bus1
        if (_currentPolylineIndex < _nashikPuneRoute.length - 1) {
          final currentLocation = _bus1Location ?? _nashikPuneRoute[0];
          final nextLocation = _nashikPuneRoute[_currentPolylineIndex + 1];
          final distance = currentLocation.distanceTo(nextLocation);
          final direction = nextLocation - currentLocation;
          final distanceToMove = 0.001;

          if (distance > distanceToMove) {
            // Move the marker towards the next location
            final offset = direction.normalized() * distanceToMove;
            _bus1Location = currentLocation + offset;
          } else {
            // Move the marker to the next location
            _currentPolylineIndex++;
            _bus1Location = nextLocation;
          }
        }

        // Update the marker position
        _markers.removeWhere((marker) => marker.markerId.value == '1');
        _markers.add(Marker(
          markerId: MarkerId('1'),
          position: _bus1Location!,
          infoWindow: InfoWindow(title: 'Nashik - Pune'),
        ));
      });

    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _mapController!.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: _nashikPuneRoute[0],
        zoom: 7.0,
      ),
    ));
  }


  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Tracker'),

      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              markers: _markers,
              polylines: _polylines,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 7.0,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: _buses.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_buses[index].name),
                  subtitle: Text(
                      'Lat: ${_buses[index].lat.toString()}, Lng: ${_buses[index].lng.toString()}'),
                  onTap: () {
// Move the camera to the selected bus's location
                    _mapController!.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          target: LatLng(
                            _buses[index].lat,
                            _buses[index].lng,
                          ),
                          zoom: 15.0,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
class ExtendedLatLng extends LatLng {
  ExtendedLatLng(double latitude, double longitude) : super(latitude, longitude);

  ExtendedLatLng operator +(LatLng other) {
    return ExtendedLatLng(latitude + other.latitude, longitude + other.longitude);
  }

  ExtendedLatLng operator -(LatLng other) {
    return ExtendedLatLng(latitude - other.latitude, longitude - other.longitude);
  }

  ExtendedLatLng operator *(double factor) {
    return ExtendedLatLng(latitude * factor, longitude * factor);
  }
  double distanceTo(LatLng other) {
    final double earthRadius = 6378137.0;
    final double dLat = (other.latitude - latitude) * pi / 180;
    final double dLng = (other.longitude - longitude) * pi / 180;
    final double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(latitude * pi / 180) * cos(other.latitude * pi / 180) * sin(dLng / 2) * sin(dLng / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    final double distance = earthRadius * c;
    return distance;
  }

  ExtendedLatLng normalized() {
    final double distance = sqrt(latitude * latitude + longitude * longitude);
    return ExtendedLatLng(latitude / distance, longitude / distance);
  }
}


class Bus {
  final int id;
  final double lat;
  final double lng;
  final String name;

  Bus({
    required this.id,
    required this.lat,
    required this.lng,
    required this.name,
  });
}
class Location {
  final double lat;
  final double lng;

  Location({required this.lat, required this.lng});
}

class BusLocationUpdater {
  final List<Location> _locations;
  final Function(Location) _onLocationUpdate;
  final int _busId;

  int _currentIndex = 0;
  late Timer _timer;

  BusLocationUpdater(
      {required List<Location> locations,
        required Function(Location) onLocationUpdate,
        required int busId})
      : _locations = locations,
        _onLocationUpdate = onLocationUpdate,
        _busId = busId {
    _timer = Timer.periodic(Duration(seconds: 5), _updateLocation);
  }

  void _updateLocation(Timer timer) {
    _onLocationUpdate(_locations[_currentIndex]);
    _currentIndex++;
    if (_currentIndex >= _locations.length) {
      _currentIndex = 0;
    }
  }

  void stop() {
    _timer.cancel();
  }
}