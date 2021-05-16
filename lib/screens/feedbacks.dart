import 'package:flutter/material.dart';

class Feedbacks extends StatefulWidget {
  @override
  _FeedbacksState createState() => _FeedbacksState();
}

class _FeedbacksState extends State<Feedbacks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Feedback'),
        backgroundColor: Colors.indigo,
        elevation: 0.0,
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
      body: Container(
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            Flexible(
              child: Card(
                color: Color(0xff836953),
                child: Text(
                  'Testing the card and i\'m putting in a lengthy sentence to test how this box works',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Card(
                color: Color(0xffFFDFD3),
                child: Text(
                  'testing using a smaller text',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Card(
                color: Color(0xff836953),
                child: Text(
                  'i hate this app. it\'s so ugly',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Card(
                color: Color(0xffFFDFD3),
                child: Text(
                  'another card for the feedback',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Card(
                color: Color(0xff836953),
                child: Text(
                  'i really hope my app works',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
