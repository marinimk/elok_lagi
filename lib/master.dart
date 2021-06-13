//kinda like a master page for the appbar and bottomnavigationbar
//import 'dart:ffi';

//import 'package:elok_lagi_psm/view/register.dart';
// import 'dart:math';

// import 'dart:html';

import 'package:elok_lagi/otherprj/home.dart';
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
  int _currentIndex = 0;

  final List<Widget> _bottomApp = [
    Home(),
    Feedbacks(),
    Profile(),
  ];

  void onTapBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

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
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          // backgroundColor: Colors.black,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          unselectedIconTheme: IconThemeData(
            color: Colors.black,
          ),
          onTap: onTapBar,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Feed',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              label: 'Feedback',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Profile',
            ),
          ],
        ),
        body: _bottomApp[_currentIndex],
      ),
    );
  }
}
