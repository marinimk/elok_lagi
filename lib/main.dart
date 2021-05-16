import 'package:elok_lagi/master.dart';
import 'package:elok_lagi/screens/feed.dart';
import 'package:elok_lagi/screens/login.dart';
import 'package:elok_lagi/screens/profile.dart';
import 'package:elok_lagi/screens/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.green,
          //accentColor: Colors.yellow,
        ),
        home: new Login());
  }
}
