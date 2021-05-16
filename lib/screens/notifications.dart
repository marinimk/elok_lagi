import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Notification'),
        backgroundColor: Colors.yellow,
        elevation: 0.0,
        //leading: BackButton(),
        actions: [
          IconButton(
            icon: Icon(Icons.chevron_right_sharp),
            onPressed: () => {
              print("marini mk"),
            },
          ),
        ],
      ),
      body: Container(
        //color: Colors.yellow,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/noti.png'),
          ),
        ),
        // child: Text(
        //   "Notification page TING TING",
        //   style: TextStyle(
        //     fontSize: 20,
        //     fontWeight: FontWeight.bold,
        //   ),
        //),
      ),
    );
  }
}
