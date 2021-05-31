import 'package:elok_lagi/master.dart';
import 'package:elok_lagi/view/feed.dart';
import 'package:elok_lagi/view/login.dart';
import 'package:elok_lagi/view/profile.dart';
import 'package:elok_lagi/view/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.purple,
          //accentColor: Colors.yellow,
        ),
        home: new Login());
  }
}
