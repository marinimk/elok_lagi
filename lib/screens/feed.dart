//import 'dart:ffi';

//import 'package:elok_lagi_psm/screens/register.dart';
// import 'dart:math';

import 'package:elok_lagi/screens/feedbacks.dart';
import 'package:elok_lagi/screens/notifications.dart';
import 'package:elok_lagi/screens/profile.dart';
import 'package:elok_lagi/screens/search.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
// import 'dart:ui';

class Feed extends StatefulWidget {
  Feed({Key key}) : super(key: key);

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text('Feed'),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          //titleSpacing: 30,
          //leadingWidth: 0,
          leading: BackButton(),
          actions: [
            IconButton(
              icon: Icon(Icons.chevron_right_sharp),
              onPressed: () => {
                print("marini mk"),
              },
            ),
          ],
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              color: Colors.red,
              width: 10,
              alignment: Alignment.centerRight,
              child: FractionallySizedBox(
                widthFactor: 0.5,
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/burger.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: 0.5,
                child: Container(
                  color: Colors.green,
                  width: 10,
                  child: Stack(
                    children: [
                      Card(
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: [
                            Flexible(
                              child: Text(
                                  'Testing the card and i\'m putting in a lengthy sentence to test how this box works'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Text('marini'),
            // Container(
            //   child: Stack(
            //     children: [
            //       Card(
            //         color: Colors.purple,
            //         margin: EdgeInsets.all(20),
            //         child: Row(
            //           children: [
            //             Text('marini comel'),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            //   margin: EdgeInsets.only(top: 200.0),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.only(
            //       topLeft: Radius.circular(60.0),
            //       topRight: Radius.circular(60.0),
            //     ),
            //   ),
            //   //padding: EdgeInsets.symmetric(horizontal: 125.0),
            // ),
          ],
        ),
      ),
    );
  }
}
