import 'package:elok_lagi/view/screens/feedbacks.dart';
import 'package:elok_lagi/view/screens/notifications.dart';
import 'package:elok_lagi/view/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:elok_lagi/view/widgets/category.dart';
import 'package:elok_lagi/view/widgets/featured.dart';
import 'package:elok_lagi/view/widgets/product-list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.red[50],
                      offset: Offset(2, 2),
                      blurRadius: 10)
                ],
              ),
              child: ListTile(
                leading: Icon(Icons.search, color: Colors.red[300]),
                title: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search for food and restaurent"),
                ),
                trailing: Icon(
                  Icons.filter_list,
                  color: Colors.red[300],
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Category",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                    ),
                  ),
                ),
              ],
            ),
            // Featured(),
            // SizedBox(
            //   height: 10,
            // ),
            Category(),
            SizedBox(
              height: 0,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Food Lists",
                    style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                    ),
                  ),
                ),
              ],
            ),
            ProductList()
          ],
        ),
      ),
    );
  }
}
