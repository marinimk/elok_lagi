import 'package:elok_lagi/view/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:elok_lagi/view/widgets/home/category.dart';
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
              titleSeparator('Category'),
              Category(),
              titleSeparator('Restaurant List'),
              RestaurantList(),
              // Container(
              //   height: 100,
              //   child: Text('data'),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Row titleSeparator(String title) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: colorsConstBrown[100],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            title,
            style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w800,
                color: colorsConstBrown[500]),
          ),
        ),
        Expanded(
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: colorsConstBrown[100],
            ),
          ),
        ),
      ],
    );
  }
}
