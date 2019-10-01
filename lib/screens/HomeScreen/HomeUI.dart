import 'package:flutter/material.dart';
import 'package:studymate/services/Authentication.dart';
import 'package:studymate/widgets/DrawerTile.dart';
import 'package:studymate/widgets/HomeTile.dart';

class HomeScreen extends StatefulWidget {
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BaseAuthentication _auth = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Icon(
                  Icons.account_circle,
                  size: 90.0,
                  color: Colors.white54,
                ),
                decoration: BoxDecoration(color: Colors.deepPurple),
              ),
              DrawerTile(Icons.person, 'Profile',
                  () => {Navigator.pushNamed(context, '/profileUI')}),
              DrawerTile(Icons.note, 'Reminders', () => {}),
              DrawerTile(Icons.info, 'About Us', () => {}),
              DrawerTile(Icons.settings, 'Settings', () => {}),
              DrawerTile(Icons.exit_to_app, 'Logout', () {
                _auth.signOut();
                Navigator.pushNamed(context, '/signin');
              }),
            ],
          ),
        ),
        body:
        // SingleChildScrollView(
        //   child: Column(
        //     children: <Widget>[
        //       TopBar(),
        //     RadialProgress(),
        //     Container(
        //   margin: EdgeInsets.symmetric(vertical: 20.0),
        //   height: 200.0,
        //   child: ListView(
        //     scrollDirection: Axis.horizontal,
        //     children: <Widget>[
        //       Container(
        //         width: 160.0,
        //         color: Colors.red,
        //       ),
        //       Container(
        //         width: 160.0,
        //         color: Colors.blue,
        //       ),
        //       Container(
        //         width: 160.0,
        //         color: Colors.green,
        //       ),
        //       Container(
        //         width: 160.0,
        //         color: Colors.yellow,
        //       ),
        //       Container(
        //         width: 160.0,
        //         color: Colors.orange,
        //       ),
        //     ],
        //   ),
        // ),
        //     ],
        //   ),
        // ), 
        
        ListView(
          primary: false,
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: HomeTile(Icons.calendar_today, "Daily Schedule",
                      Colors.lightBlue, "/daily"),
                ),
                Expanded(
                  child: HomeTile(Icons.timeline, "Progress Tracking",
                      Colors.cyan, "/medicalRecord"),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: HomeTile(
                      Icons.book, "Subject Manager", Colors.green, "/subject"),
                ),
                Expanded(
                  child: HomeTile(Icons.local_activity, "Activity Manager",
                      Colors.deepPurpleAccent, "/activity"),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: HomeTile(Icons.calendar_today, "Schedule Manager",
                      Colors.cyan, "/scheduleManager"),
                ),
                Expanded(
                  child: HomeTile(Icons.supervised_user_circle, "Profile",
                      Colors.red, "/accounttype"),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: HomeTile(Icons.calendar_today, "Appointments",
                      Colors.amber, "/appointment"),
                ),
                Expanded(
                  child: HomeTile(
                      Icons.stars, "Reward Manager", Colors.pink, "/s_rewards"),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child:
                      HomeTile(Icons.chat, "Chat", Colors.blueAccent, "/chat"),
                ),
                Expanded(
                  child: HomeTile(
                      Icons.build, 'Test UIs', Colors.black, '/testUI'),
                )
              ],
            ),
          ],
        )

    //      bottomNavigationBar: BottomNavigationBar(
    //    currentIndex: 0, // this will be set when a new tab is tapped
    //    items: [
    //      BottomNavigationBarItem(
    //        icon: new Icon(Icons.home),
    //        title: new Text('Home'),
    //      ),
    //      BottomNavigationBarItem(
    //        icon: new Icon(Icons.mail),
    //        title: new Text('Messages'),
    //      ),
    //      BottomNavigationBarItem(
    //        icon: Icon(Icons.person),
    //        title: Text('Profile')
    //      )
    //    ],
    //  ),
        );
  }
}
