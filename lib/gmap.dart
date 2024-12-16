import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:bustracking/constants.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);

  @override
  State<OrderTrackingPage> createState() => OrderTrackingPageState();
}

class OrderTrackingPageState extends State<OrderTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(20.014104039870233, 73.81500863615462);
  static const LatLng destination = LatLng(20.019446828396394, 73.83073710840652);


  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  void getCurrentLocation () async {
    Location location = Location();
    LocationData? locationData = await location.getLocation();
    setState(() {
      currentLocation = locationData;
    });
    if (_controller.future != null) {
      GoogleMapController googleMapController = await _controller.future;
      location.onLocationChanged.listen((newLoc) {
        googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
              zoom: 13.5,
              target: LatLng(
                  newLoc.latitude!,
                  newLoc.longitude!)
          ),
        ),
        );
        setState(() {
          currentLocation = newLoc;
        });
      },);
    }
  }

  void getPolyPointss() async{
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if(result.points != null && result.points.isNotEmpty){
      for (PointLatLng point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      setState(() {});

    }


  }

  void setCustomMarkerIcon(){
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "assets/Pin_source.png").then((icon){
      sourceIcon =icon;
    },);
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "assets/Pin_destination.png").then((icon){
      destinationIcon =icon;
    },);
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, "assets/Badge.png").then((icon){
      currentLocationIcon =icon;
    },);
  }

  @override
  void initState() {
    setCustomMarkerIcon();
    getCurrentLocation();
    getPolyPointss();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: currentLocation == null?
            Center( child: Text("Loading"),)
            :GoogleMap(initialCameraPosition: CameraPosition(
          target: LatLng(currentLocation!.latitude!,currentLocation!.longitude!),
          zoom: 13.5,
      ),
        polylines: {
        Polyline(polylineId: PolylineId("route"),
          points: polylineCoordinates,
          color: Colors.red,
          width: 6
        ),
        },
        markers: {
           Marker(
            markerId: const MarkerId("currentLocation"),
            icon: currentLocationIcon,
            position: LatLng(currentLocation!.latitude!,currentLocation!.longitude!),
          ),
           Marker(
            markerId: MarkerId("source"),
            icon: sourceIcon,
          position: sourceLocation,
        ),
           Marker(
          markerId: MarkerId("destination"),
          icon: destinationIcon,
          position: destination,
        ),
        },
        onMapCreated: (mapController){
            _controller.complete(mapController);

        },
      ),
    );
  }
}
