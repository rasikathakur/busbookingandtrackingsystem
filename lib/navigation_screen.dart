import 'dart:async';
import 'package:bustracking/first_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'dart:math' show cos, sqrt, asin;

class NavigationScreen extends StatefulWidget {
  final double slat;
  final double slng;
  final double dlat;
  final double dlng;
  final double blat;
  final double blng;
  NavigationScreen(this.slat, this.slng, this.dlat, this.dlng, this.blat, this.blng);
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final Completer<GoogleMapController?> _controller = Completer();
  Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Location location = Location();
  Marker? sourcePosition, destinationPosition, mycurrentPosition, busPosition;
  loc.LocationData? _currentPosition;
  LatLng busLocation = LatLng(20.019446828396394, 73.83073710840652);
  //LatLng _currentPos = LatLng(20.019446828396394, 73.83073710840652);
  StreamSubscription<loc.LocationData>? locationSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNavigation();
    addMarker();
    print(widget.blat);
    print(widget.blng);
    //getMarkerData();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    locationSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: sourcePosition == null
          ? Center(child: CircularProgressIndicator()):
          Stack(
            children: [
              GoogleMap(
                zoomControlsEnabled: false,
                polylines: Set<Polyline>.of(polylines.values),
                initialCameraPosition: CameraPosition(
                target: LatLng(widget.blat, widget.blng),
                zoom: 13,
              ),
                markers: {sourcePosition!, destinationPosition!, busPosition!, mycurrentPosition!},
                onTap: (latlng){
                  print(latlng);
                },
                onMapCreated: (GoogleMapController controller){
                  _controller.complete(controller);
                },
              ),
              Positioned(
                  top: 30,
                  left: 15,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>FirstPage()),
                        (route)=>false);
                    },
                    child: Icon(Icons.arrow_back),
                  ),
              ),
              Positioned(
                bottom: 10,
                  right: 10,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.blue),
                    child: Center(
                      child: IconButton(
                        icon: Icon(
                          Icons.navigation_outlined,
                          color: Colors.white,
                        ),
                        onPressed: () async{
                          await launchUrl(Uri.parse(
                            'google.navigation:q=${widget.slat}, ${widget.slng} &key=AIzaSyBU8FmmHUeNdG9RFG3EGOqzu9aM4AO9DJc'));
                        },
                      ),
                    ),
                  )
              ),
            ],
          )
    );
  }

  /*Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void initMarker(specify, specifyId) async{
    var markerIdVal = specifyId;
    final MarkerId markerId = MarkerId(markerIdVal);
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(specify['src'].latitude, specify['src'].longitude),
    );
    setState(() {
      markers[markerId] = marker;
    });

  }

  getMarkerData() async{
    FirebaseFirestore.instance.collection('Schedules').get().then((myMockData){
      if(myMockData.docs.isNotEmpty){
        for(int i=0; i<myMockData.docs.length; i++){
          initMarker(myMockData.docs[i].data, myMockData.docs[i].id);
        }
      }
    });
  }*/

  getNavigation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    final GoogleMapController? controller = await _controller.future;
    location.changeSettings(accuracy: loc.LocationAccuracy.high);
    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    if (_permissionGranted == loc.PermissionStatus.granted) {
      _currentPosition = await location.getLocation();
      busLocation =
          LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!); //snapshot
      locationSubscription =
          location.onLocationChanged.listen((LocationData currentLocation) {
        controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
          zoom: 13,
        )));
        if (mounted) {
          controller
              ?.showMarkerInfoWindow(MarkerId(sourcePosition!.markerId.value));
          setState(() {
            busLocation =
                LatLng(currentLocation.latitude!, currentLocation.longitude!);   //snapshot
            sourcePosition = Marker(
              markerId: MarkerId(currentLocation.toString()),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
              position:
                  LatLng(currentLocation.latitude!, currentLocation.longitude!),
              infoWindow: InfoWindow(
                      title: 'Source: ${double.parse(
                          (getDistance(LatLng(widget.slat, widget.slng)).toStringAsFixed(2)))} km'
              ),
              onTap: () {
                print('Marker tapped');
              },
            );
          });
          getDirections(LatLng(widget.slat, widget.slng));
        }
      });
    }
  }

  getDirections(LatLng dst) async {
    List<LatLng> polylineCoordinates = [];
    List<dynamic> points = [];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyBU8FmmHUeNdG9RFG3EGOqzu9aM4AO9DJc',
        PointLatLng(busLocation.latitude, busLocation.longitude),
        PointLatLng(dst.latitude, dst.longitude),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        points.add({'lat': point.latitude, 'lng': point.longitude});
      });
    } else {
      print(result.errorMessage);
    }
    addPolyline(polylineCoordinates);
  }

  addPolyline(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.blue,
        points: polylineCoordinates,
        width: 5);
    polylines[id] = polyline;
    setState(() {});
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742*asin(sqrt(a));
  }

  double getDistance(LatLng destposition) {
    return calculateDistance(busLocation.latitude, busLocation.longitude, destposition.latitude, destposition.longitude);
  }
  addMarker() {
    setState(() {
      sourcePosition = Marker(
          markerId: MarkerId('source'),
          position: LatLng(widget.slat, widget.slng),
          infoWindow: InfoWindow(
            title: "Source"
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));
      destinationPosition = Marker(
          markerId: MarkerId('destination'),
          infoWindow: InfoWindow(
              title: "Destination"
          ),
          position: LatLng(widget.dlat, widget.dlng),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen));
      mycurrentPosition = Marker(
          markerId: MarkerId('current'),
          position: busLocation,
          infoWindow: InfoWindow(
              title: "MyCurrentLocation"
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));
      busPosition = Marker(
          markerId: MarkerId('bus'),
          infoWindow: InfoWindow(
              title: "Bus"
          ),
          position: LatLng(widget.blat, widget.blng),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange));
    });
  }}
