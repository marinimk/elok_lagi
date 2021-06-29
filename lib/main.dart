import 'package:elok_lagi/master.dart';
import 'package:elok_lagi/view/screens/home.dart';
import 'package:elok_lagi/view/screens/profile.dart';
import 'package:elok_lagi/view/wrapper.dart';
import 'package:elok_lagi/view/authenthicate/signinup.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Wrapper(),
    );
  }
}
