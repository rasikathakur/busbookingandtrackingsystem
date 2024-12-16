import 'package:bustracking/choose.dart';
import 'package:bustracking/load.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'offers.dart';

class NewPage extends StatefulWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  _NewPageState createState() => _NewPageState();
}


class _NewPageState extends State<NewPage> {


  late String _selectedLocation = '';
  late String _selectedLocations = '';

  var _isHovering = false;
   late DateTime _selectedDate;
  final List<String> imgList = [
    "https://www.linkpicture.com/q/banner1_2.png",
    "https://www.linkpicture.com/q/banner1_3.png",
    "https://www.linkpicture.com/q/banner2_17.png",
    "https://i.ibb.co/4m5FWZ3/banner3.png",
  ];


  // Method to display the date picker
  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));

    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }


  late String str1;
  late String str2;

  void _showSearch() async {
    final selectedLocation = await showSearch(
      context: context,
      delegate: CustomSearch(selectedLocation: _selectedLocation),
    );

    if (selectedLocation != null) {
      setState(() {
        _selectedLocation = selectedLocation;
      });
    }
  }



  void _showSearchs() async {
    final selectedLocations = await showSearch(
      context: context,
      delegate: CustomSearchs(selectedLocations: _selectedLocations),
    );

    if (selectedLocations != null) {
      setState(() {
        _selectedLocations = selectedLocations;
      });
    }
  }

  void chooseBuses() {
    if (str1 !='From' && str2 != 'To' && _selectedDate!=null) {
      if(str1 != str2){
        Navigator.push(
          context,
          MaterialPageRoute(settings: RouteSettings(arguments: [str1,str2]),builder: (context) => LoadingPage()),
        );
      }
      else{
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Error',
                textAlign: TextAlign.start,
              ),
              content: Text('Source and Destination could not be same'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }

    } else {
      // Display a message to the user that they need to select From, To, and Date.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
                'Error',
              textAlign: TextAlign.start,
            ),
            content: Text('Please Select the Source and Destination'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }


  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Material(
                color: Colors.transparent,
                elevation: 8,
                child: Container(
                  width: 393,
                  height: 450,
                  constraints: BoxConstraints(
                    maxWidth: double.infinity,
                    maxHeight: double.infinity,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepPurpleAccent[700],
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x33000000),
                        offset: Offset(0, 2),
                        spreadRadius: 5,
                      )
                    ],
                  ),
                  child: Stack(
                    children : [

                            Padding(
                              padding: const EdgeInsets.only(left: 30,top: 55),
                              child: Text(
                                  'book_tickets',
                              style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                    ),
                              ).tr(),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(left: 310,top: 25),
                        child: CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(
                            "assets/logo_rm.png",
                          ),
                        ),
                      ),


                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,top: 120),
                        child: Container(
                        width: 355.5,
                        height: 300,
                          constraints: BoxConstraints(
                            maxWidth: double.infinity,
                            maxHeight: double.infinity,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x33000000),
                                offset: Offset(0, 2),
                                spreadRadius: 5,
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              MouseRegion(
                                onHover: (event) {
                                  setState(() {
                                    _isHovering = true;
                                  });
                                },
                                onExit: (event) {
                                  Future.delayed(Duration(milliseconds: 500), () {
                                    setState(() {
                                      _isHovering = false;
                                    });
                                  });
                                },
                                child: GestureDetector(
                                  onTap: _showSearch,
                                  child: Container(
                                    //from row container
                                    decoration: BoxDecoration(
                                      color: _isHovering ? Colors.deepPurpleAccent[50] : Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 20,left: 10,right: 10),
                                      child: Row(
                                       children: [
                                         FaIcon(
                                           FontAwesomeIcons.mapPin,
                                           color: Colors.deepPurpleAccent[700],
                                           size: 30,
                                         ),
                                         Padding(
                                           padding: const EdgeInsets.only(left: 15,right: 10),
                                           child: Text(
                                             str1 = _selectedLocation.isNotEmpty ? _selectedLocation : 'from',
                                           ).tr(),

                                         ),
                                       ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 2,
                              ),
                              MouseRegion(
                                onHover: (event) {
                                  setState(() {
                                    _isHovering = true;
                                  });
                                },
                                onExit: (event) {
                                  Future.delayed(Duration(milliseconds: 500), () {
                                    setState(() {
                                      _isHovering = false;
                                    });
                                  });
                                },
                                child: GestureDetector(
                                  onTap: _showSearchs,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _isHovering ? Colors.deepPurpleAccent[50] : Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 15,left: 10,right: 10),
                                      child: Row(
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.locationDot,
                                            color: Colors.deepPurpleAccent[700],
                                            size: 30,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 15,right: 10),
                                            child: Text(
                                              str2=_selectedLocations.isNotEmpty ? _selectedLocations : 'to',
                                            ).tr(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 2,
                              ),
                              MouseRegion(
                                onHover: (event) {
                                  setState(() {
                                    _isHovering = true;
                                  });
                                },
                                onExit: (event) {
                                  Future.delayed(Duration(milliseconds: 500), () {
                                    setState(() {
                                      _isHovering = false;
                                    });
                                  });
                                },
                                child: GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: _isHovering ? Colors.deepPurpleAccent[50] : Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 15,left: 10,right: 10),
                                      child: Row(
                                        children: [
                                          FaIcon(
                                            Icons.date_range_outlined,
                                            color: Colors.deepPurpleAccent[700],
                                            size: 30,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 15,right: 10),
                                            child: InkWell(
                                              onTap: () {
                                                _selectDate(context);
                                              },
                                                child: Text(
                                                  _selectedDate == null
                                                      ? 'Date of Journey'
                                                      : '${_selectedDate.toLocal()}'
                                                      .split(' ')[0],
                                                ),

                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 2,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: ElevatedButton(
                                  onPressed:(){
                                    chooseBuses();
                                  },
                                  child: Text(
                                    'SEARCH BUSES',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
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
                              ),
                            ],
                          ),
                    ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                color: Colors.deepPurpleAccent[700],
                child: Column(
                  children: [
                    Container(
                      width: 400,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              spreadRadius: 7,
                              offset: Offset(1,1),
                              color: Colors.grey.withOpacity(0.2),
                            )
                          ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(child: Icon(
                                  Icons.local_offer_rounded,
                                  size: 40,
                                  color: Colors.grey[700],
                                ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    "OFFERS",
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w900,
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: RichText(
                                      text: TextSpan(
                                        text: "_",
                                        style: TextStyle(
                                          color: Colors.lightBlue[700],
                                        ),
                                        children: [
                                          TextSpan(
                                              text: "View All",
                                              style: TextStyle(
                                                color: Colors.lightBlue[700],
                                                fontWeight: FontWeight.w900,
                                                fontSize: 17,
                                              ),
                                              recognizer: TapGestureRecognizer()..onTap=()=>Get.to(()=>OffersPage())
                                          ),
                                        ],
                                      )

                                  ),
                                ),
                              ],

                            ),
                            Text(
                              'Get best deals with great discounts and offers',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),

                            ),
                          ],
                        ),
                      ),


                    ),

                    Container(
                      color: Colors.white,
                      child: CarouselSlider(
                        items:imgList
                            .map((item) => Container(
                          child: Center(
                            child: Image.network(
                              item,
                              fit: BoxFit.cover,
                              width: 500,
                            ),
                          ),
                        ))
                            .toList(),
                        options:CarouselOptions(
                          autoPlay:true,
                          aspectRatio:2.0,
                          enlargeCenterPage: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

    );
  }
}


class CustomSearch extends SearchDelegate
{
  final String selectedLocation;
  CustomSearch({required this.selectedLocation});
  List<String> allData = [
    'RK', 'K. K. Wagh', 'CBS', 'Nashikroad', 'Adgaon', 'Ozar', 'Nimani'
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: (){
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: (){
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for(var item in allData){
      if(item.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(item);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index){
          var result = matchQuery[index];
          return GestureDetector(
            onTap: () {
              close(context, result);
            },
            child: ListTile(
              title: Text(result),
            ),
          );
        }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for(var item in allData){
      if(item.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(item);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index){
          var result = matchQuery[index];
          return ListTile(
            onTap: () {
              // Call the showResults method to update the query and close the search bar
              showResults(context);
            },
            title: Text(result),
          );
        }
    );
  }

  @override
  void showResults(BuildContext context) {
    // Update the query property with the selected location
    query = selectedLocation;

    // Close the search bar and return the selected location to the caller
    close(context, query);
  }

}


class CustomSearchs extends SearchDelegate
{
  final String selectedLocations;
  CustomSearchs({required this.selectedLocations});
  List<String> allData = [
    'RK', 'K. K. Wagh', 'CBS', 'Nashikroad', 'Adgaon', 'Ozar', 'Nimani'
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: (){
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: (){
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for(var item in allData){
      if(item.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(item);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index){
          var result = matchQuery[index];
          return GestureDetector(
            onTap: () {
              close(context, result);
            },
            child: ListTile(
              title: Text(result),
            ),
          );
        }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for(var item in allData){
      if(item.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(item);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index){
          var result = matchQuery[index];
          return GestureDetector(
            onTap: () {
              close(context, result);
            },
            child: ListTile(
              title: Text(result),
            ),
          );
        }
    );
  }
  @override
  void showResults(BuildContext context) {
    // Update the query property with the selected location
    query = selectedLocations;

    // Close the search bar and return the selected location to the caller
    close(context, query);
  }

}