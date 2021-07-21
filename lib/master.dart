import 'package:elok_lagi/view/screens/faq.dart';
import 'package:elok_lagi/view/screens/home/home.dart';
import 'package:elok_lagi/view/screens/feedbacks.dart';
import 'package:elok_lagi/view/screens/profile/profile.dart';
import 'package:elok_lagi/view/widgets/constants.dart';
import 'package:elok_lagi/view/widgets/elAppBar.dart';
import 'package:flutter/material.dart';

class Master extends StatefulWidget {
  Master({Key key}) : super(key: key);

  @override
  _MasterState createState() => _MasterState();
}

class _MasterState extends State<Master> {
  Widget currentScreen = Home(); // Our first view in viewport
  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    Home(),
    FAQ(),
    Feedbacks(),
    Profile(),
    // Hehe(),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: ElAppBar(),
        body: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
        //TODO: the FAB follows the keyboard kalau bukak (https://github.com/bizz84/bottom_bar_fab_flutter/issues/2)
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          child: Icon(Icons.add),
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: colorsConst[900],
          elevation: 0,
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    bottomNaviBtn(Home(), 0, Icons.home, 'Home'),
                    bottomNaviBtn(FAQ(), 1, Icons.question_answer, 'FAQ'),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    bottomNaviBtn(Feedbacks(), 2, Icons.chat, 'Feedback'),
                    bottomNaviBtn(Profile(), 3, Icons.person, 'Profile'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  MaterialButton bottomNaviBtn(
      Widget page, int currTab, IconData icon, String title) {
    return MaterialButton(
      minWidth: 40,
      onPressed: () => setState(
        () {
          currentScreen = page;
          currentTab = currTab;
        },
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            color: currentTab == currTab ? colorsConst[500] : Colors.grey,
          ),
          Text(
            title,
            style: TextStyle(
              color: currentTab == currTab ? colorsConst[500] : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
