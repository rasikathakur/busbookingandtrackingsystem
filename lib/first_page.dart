import 'package:bustracking/dashboard.dart';
import 'package:bustracking/events.dart';
import 'package:bustracking/nav.dart';
import 'package:bustracking/notifications.dart';
import 'package:bustracking/privacypo.dart';
import 'package:bustracking/settings.dart';
import 'package:bustracking/src/features/authentication/screens/profile/profile_screen.dart';
import 'package:bustracking/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:bustracking/contacts.dart';
import 'package:bustracking/feedback.dart';
import 'package:bustracking/my_drawer_header.dart';
import 'package:bustracking/notes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'list_of_routes.dart';
import 'new.dart';

class FirstPage extends StatefulWidget{
  @override
  _FirstPageState createState()=>_FirstPageState();


}

class _FirstPageState extends State<FirstPage>{
  var currentPage = DrawerSections.dashboard;

  get leading => null;
  @override
  Widget build(BuildContext context){
    var container;
    if(currentPage == DrawerSections.dashboard){
      container = NewPage();

    } else if(currentPage == DrawerSections.contacts){
      container = ContactsPage();
    }
    else if(currentPage == DrawerSections.events){
      container = EventsPage();
    }
    else if(currentPage == DrawerSections.notes){
      container = FirstPage();
    }
    else if(currentPage == DrawerSections.settings){
      container = BusTracker();
    }
    else if(currentPage == DrawerSections.notifications){
      container = NotificationsPage();
    }
    else if(currentPage == DrawerSections.privacy_policy){
      container = PrivacypoPage();
    }
    else if(currentPage == DrawerSections.send_feedback){
      container = FeedbackPage();
    }
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.deepPurpleAccent[700], // change color here
          ),
          backgroundColor: Colors.white,
          title: Text(
              "BOTO",
            style: TextStyle(
              fontFamily: 'blackCupertino',
              fontSize: 30,
              color: Colors.deepPurpleAccent[700],
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(
                    Icons.directions_bus_rounded,
                    color: Colors.deepPurpleAccent[700],
                ),
              ),
              Tab(
                icon: Icon(
                    Icons.star,
                    color: Colors.deepPurpleAccent[700],
                ),
              ),
              Tab(
                icon: Icon(
                    Icons.person,
                    color: Colors.deepPurpleAccent[700],
                ),
              ),
              Tab(
                icon: Icon(
                    FontAwesomeIcons.locationArrow,
                    color: Colors.deepPurpleAccent[700],
                ),
              ),
            ],
          ),
          ),
        body:
        Column(
          children: [
            Expanded(
              child: TabBarView(
              children: [
                Center(child: container = NewPage(),),
                Center(child: container = ProfileScreen(),),
                Center(child: container = LocationScreen(),),
                Center(child: container = ListRoutePage(),),
              ],
          ),
            ),

          ]
        ),


        drawer: Drawer(
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  MyHeaderDrawer(),
                  MyDrawerList(),
                ],
              ),
            ),
          ),
        ),

      ),
    );
  }
  Widget MyDrawerList(){
    return Container(
      padding: EdgeInsets.only(top: 15,),
      child: Column(
        children: [
          menuItem(
            1,
            "Book Tickets",
            Icons.dashboard_outlined,
            currentPage == DrawerSections.dashboard?true:false
          ),
          menuItem(
              2,
              "Wallet",
              Icons.people_alt_outlined,
              currentPage == DrawerSections.contacts?true:false
          ),
          menuItem(
              3,
              "Track Your Bus",
              Icons.event,
              currentPage == DrawerSections.events?true:false
          ),
          menuItem(
              4,
              "Check Terms and conditions",
              Icons.notes,
              currentPage == DrawerSections.notes?true:false
          ),
          menuItem(
              5,
              "Settings",
              Icons.settings_outlined,
              currentPage == DrawerSections.settings?true:false
          ),
          menuItem(
              6,
              "Notifications",
              Icons.notifications_outlined,
              currentPage == DrawerSections.notifications?true:false
          ),
          menuItem(
              7,
              "Privacy Policy",
              Icons.privacy_tip_outlined,
              currentPage == DrawerSections.privacy_policy?true:false
          ),
          menuItem(
              8,
              "Send Feedback",
              Icons.feedback_outlined,
              currentPage == DrawerSections.send_feedback?true:false
          ),
        ],
      ),
    );
  }
  Widget menuItem(int id, String title, IconData icon, bool selected){
    return Material(
      color: selected?Colors.grey[300]:Colors.transparent,
      child: InkWell(
        onTap: (){
          Navigator.pop(context);
          setState(() {
            if(id==1){
              currentPage = DrawerSections.dashboard;
            } else if(id==2){
              currentPage = DrawerSections.contacts;
            }
            else if(id==3){
              currentPage = DrawerSections.events;
            }
            else if(id==4){
              currentPage = DrawerSections.notes;
            }
            else if(id==5){
              currentPage = DrawerSections.settings;
            }
            else if(id==6){
              currentPage = DrawerSections.notifications;
            }
            else if(id==7){
              currentPage = DrawerSections.privacy_policy;
            }
            else if(id==8){
              currentPage = DrawerSections.send_feedback;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(child: Icon(
                icon,
                size: 20,
                color: Colors.black,
              ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}


enum DrawerSections{
  dashboard,
  contacts,
  events,
  notes,
  settings,
  notifications,
  privacy_policy,
  send_feedback,
}