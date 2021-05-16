//kinda like a master page for the appbar and bottomnavigationbar
//import 'dart:ffi';

//import 'package:elok_lagi_psm/screens/register.dart';
// import 'dart:math';

import 'package:elok_lagi/screens/feed.dart';
import 'package:elok_lagi/screens/feedbacks.dart';
import 'package:elok_lagi/screens/notifications.dart';
import 'package:elok_lagi/screens/profile.dart';
import 'package:elok_lagi/screens/search.dart';
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
    Feed(),
    Search(),
    Notifications(),
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
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.black,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          unselectedIconTheme: IconThemeData(
            color: Colors.white,
          ),
          onTap: onTapBar,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Feed',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none_outlined),
              label: 'Notification',
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
