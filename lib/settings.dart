import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusTracker extends StatefulWidget {
  @override
  _BusTrackerState createState() => _BusTrackerState();
}

class _BusTrackerState extends State<BusTracker> {
  final Set<Marker> _markers = {};
  final List<Bus> _buses = [
    Bus(id: 1, lat: 37.7855, lng: -122.4089, name: 'Nashik - Aurangabad'),
    Bus(id: 2, lat: 37.7749, lng: -122.4194, name: 'Nashik - Pune'),
    Bus(id: 3, lat: 37.7749, lng: -122.4313, name: 'Nashik - Mumbai'),
    Bus(id: 4, lat: 37.7883, lng: -122.4073, name: 'Nashik - Nagpur'),  ];

  LatLng _center = LatLng(37.7749, -122.4194);
  GoogleMapController? _mapController;

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
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _mapController!.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: _center,
        zoom: 12.0,
      ),
    ));
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
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 12.0,
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

