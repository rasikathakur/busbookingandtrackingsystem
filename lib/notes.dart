import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/*List<Location> locations = [
  Location(
    name: 'Nashik Road',
    coordinates: LatLng(19.9483855847824, 73.84191838185549),
  ),
  Location(
    name: 'Sinnar',
    coordinates: LatLng(19.844326987585834, 73.99440422602919),
  ),
  Location(
    name: 'Sangamner',
    coordinates: LatLng(19.572907831214845, 74.20699839718966),
  ),
  Location(
    name: 'Alephata',
    coordinates: LatLng(19.18253831839706, 74.09610919718342),
  ),
  Location(
    name: 'Narayangaon',
    coordinates: LatLng(19.117598569715394, 73.97370219718235),
  ),
  Location(
    name: 'Rajguru Nagar',
    coordinates: LatLng(18.854111387215617, 73.88822789717815),
  ),
  Location(
    name: 'Bhosri',
    coordinates: LatLng(18.624733726940008, 73.85135755484485),
  ),
  Location(
    name: 'Chakan',
    coordinates: LatLng(18.754606797484417, 73.85992079348534),
  ),
  Location(
    name: 'Nashik Phata',
    coordinates: LatLng(18.609953287593267, 73.82292153950416),
  ),
  Location(
    name: 'Pune',
    coordinates: LatLng(18.52911644107558, 73.87443062600832),
  ),
];*/
/*class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location List View',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LocationListView(),
    );
  }
}*/

/*class Location {
  final String name;
  final LatLng coordinates;

  Location({
    required this.name,
    required this.coordinates,
  });
}

class LocationListView extends StatefulWidget {
  @override
  _LocationListViewState createState() => _LocationListViewState();
}

class _LocationListViewState extends State<LocationListView> {
  final ScrollController _scrollController = ScrollController();
  GoogleMapController? mapController;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  int _findMatchedLocationIndex(String locationName) {
    for (int i = 0; i < locations.length; i++) {
      if (locations[i].name == locationName) {
        return i;
      }
    }
    return -1;
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[700],
        title: Text('Locations'),
      ),
      /*body: ListView.builder(

        controller: _scrollController,
        itemCount: locations.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor:Colors.purple[700],
              child: Icon(Icons.location_on, color:Colors.white,),

            ),
            title: Text(locations[index].name),
            onTap: () {
              int matchedIndex =
              _findMatchedLocationIndex(locations[index].name);
              if (matchedIndex != -1) {
                _scrollController.animateTo(
                  matchedIndex * 72.0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeOut,
                );
              }
            },
          );
        },
      ),*/
    );
  }
