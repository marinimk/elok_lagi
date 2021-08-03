import 'package:flutter/material.dart';
import 'package:elok_lagi/view/screens/home/category.dart';
import 'package:elok_lagi/view/screens/home/restaurant_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              SizedBox(height: 5),
              Category(),
              SizedBox(height: 5),
              Divider(height: 0, thickness: 2),
              RestaurantList(),
            ],
          ),
        ),
      ),
    );
  }
}
