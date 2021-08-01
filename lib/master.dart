import 'package:elok_lagi/models/users.dart';
import 'package:elok_lagi/view/screens/cart/cart_main.dart';
import 'package:elok_lagi/view/screens/faq/faq_list.dart';
import 'package:elok_lagi/view/screens/home/home.dart';
import 'package:elok_lagi/view/screens/progress/order_progress.dart';
import 'package:elok_lagi/view/screens/profile/profile.dart';
import 'package:elok_lagi/view/widgets/constants.dart';
import 'package:elok_lagi/view/widgets/elAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Master extends StatefulWidget {
  @override
  _MasterState createState() => _MasterState();
}

class _MasterState extends State<Master> {
  Widget currentScreen = Home();
  int currentTab = 0;
  final List<Widget> screens = [
    Home(),
    OrderProgress(),
    FAQList(),
    Profile(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return SafeArea(
      child: Scaffold(
        appBar: ElAppBar2(),
        body: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
        //TODO: the FAB follows the keyboard kalau bukak (https://github.com/bizz84/bottom_bar_fab_flutter/issues/2)
        floatingActionButton: FloatingActionButton(
            elevation: 0,
            child: Icon(Icons.shopping_bag_outlined),
            onPressed: () {
              print(user.uid);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CartMain(cuid: user.uid)));
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: colorsConst[500],
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
                    bottomNaviBtn(
                        OrderProgress(), 1, Icons.fact_check, 'Orders'),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    bottomNaviBtn(FAQList(), 2, Icons.question_answer, 'FAQ'),
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
            color: currentTab == currTab ? colorsConstBrown[600] : Colors.white,
          ),
          Text(
            title,
            style: TextStyle(
              color:
                  currentTab == currTab ? colorsConstBrown[600] : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
