import 'package:bustracking/offers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}
final List<String> imgList = [
  "https://www.linkpicture.com/q/banner1_2.png",
  "https://www.linkpicture.com/q/banner1_3.png",
  "https://www.linkpicture.com/q/banner2_17.png",
  "https://i.ibb.co/4m5FWZ3/banner3.png",
 ];

class _DashboardPageState extends State<DashboardPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(120),
                bottomRight: Radius.circular(120),
              ),
              gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 200, 171, 228),
                Color.fromARGB(255,143, 118, 198),
                Color.fromARGB(255,92, 52, 156),
                Color.fromARGB(255,91, 19, 172),
               ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 35,left: 35),
            child: Text(
              "Book your tickets now!",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w900,
                fontSize: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100,left: 10,right: 10,),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade600,
                    spreadRadius: 1,
                    blurRadius: 15,
                    offset: const Offset(5, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(30),

            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  '  From',
                  style:TextStyle(
                    color: Colors.grey[700],
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(1,1),
                            color: Colors.grey.withOpacity(0.2),
                          )
                        ]
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.start_rounded,color:Colors.deepPurpleAccent),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width:1.0
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width:1.0
                              )
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          )

                      ),
                    ),
                  ),
                ),
                Text(
                  '   To',
                  style:TextStyle(
                    color: Colors.grey[700],
                    fontSize: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10,
                            spreadRadius: 7,
                            offset: Offset(1,1),
                            color: Colors.grey.withOpacity(0.2),
                          )
                        ]
                    ),
                    child: TextField(

                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.stop_circle_rounded,color:Colors.deepPurpleAccent),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width:1.0
                              )
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                  color: Colors.white,
                                  width:1.0
                              )
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          )

                      ),
                    ),
                  ),
                ),
              ],
            ),
            ),
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 340),
                  child: Row(
                    children: [
                      Expanded(child: Icon(
                        Icons.local_offer_sharp,
                        size: 40,
                        color: Colors.purple[700],
                      ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Offers",
                          style: TextStyle(
                            color: Colors.purple[700],
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

                              ),
                              children: [
                                TextSpan(
                                    text: "View All",
                                    style: TextStyle(
                                      color: Colors.purple[700],
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
                ),
                CarouselSlider(
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
              ],
            ),
          ),
      ],
      ),
    );

  }
}