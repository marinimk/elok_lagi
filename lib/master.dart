//kinda like a master page for the appbar and bottomnavigationbar
//import 'dart:ffi';

//import 'package:elok_lagi_psm/view/register.dart';
// import 'dart:math';

// import 'dart:html';

import 'package:elok_lagi/view/home.dart';
import 'package:elok_lagi/view/feed.dart';
import 'package:elok_lagi/view/feedbacks.dart';
import 'package:elok_lagi/view/notifications.dart';
import 'package:elok_lagi/view/profile.dart';
import 'package:elok_lagi/view/search.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
// import 'dart:ui';

class Master extends StatefulWidget {
  Master({Key key}) : super(key: key);

  @override
  _MasterState createState() => _MasterState();
}

class _MasterState extends State<Master> {
  Widget currentScreen = Home(); // Our first view in viewport
  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    Home(),
    // Notifications(),
    // Feedbacks(),
    Profile(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Elok Lagi',
            style: TextStyle(
              color: Colors.red[400],
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            Stack(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.notifications_none,
                    color: Colors.red[400],
                    size: 25,
                  ),
                  onPressed: () {
                    print('NOTIFICATION presed');
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Notifications()),
                    );
                  },
                ),
                Positioned(
                  left: 13,
                  top: 10,
                  child: Container(
                    width: 13,
                    height: 13,
                    decoration: BoxDecoration(
                        color: Colors.red[300],
                        borderRadius: BorderRadius.circular(20)),
                    child: FittedBox(
                      child: Text("7"),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        body: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          child: Icon(Icons.add),
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        bottomNavigationBar: BottomAppBar(
          color: Colors.black54,
          elevation: 0,
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              Home(); 
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.home,
                            color: currentTab == 0 ? Colors.blue : Colors.grey,
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                              color:
                                  currentTab == 0 ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              Notifications(); 
                          currentTab = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.chat,
                            color: currentTab == 1 ? Colors.blue : Colors.grey,
                          ),
                          Text(
                            'Chats',
                            style: TextStyle(
                              color:
                                  currentTab == 1 ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                // Right Tab bar icons

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              Feedbacks(); 
                          currentTab = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.chat,
                            color: currentTab == 3 ? Colors.blue : Colors.grey,
                          ),
                          Text(
                            'Feedback',
                            style: TextStyle(
                              color:
                                  currentTab == 3 ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen =
                              Profile(); 
                          currentTab = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.person,
                            color: currentTab == 2 ? Colors.blue : Colors.grey,
                          ),
                          Text(
                            'Profile',
                            style: TextStyle(
                              color:
                                  currentTab == 2 ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
