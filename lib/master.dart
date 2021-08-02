import 'package:elok_lagi/models/users.dart';
import 'package:elok_lagi/view/screens/cart/cart_main.dart';
import 'package:elok_lagi/view/screens/faq/faq_list.dart';
import 'package:elok_lagi/view/screens/home/home.dart';
import 'package:elok_lagi/view/screens/progress/order_progress.dart';
import 'package:elok_lagi/view/screens/profile/profile.dart';
import 'package:elok_lagi/view/widgets/constants.dart';
import 'package:elok_lagi/view/widgets/elAppBar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
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
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xfffce069),
            elevation: 0,
            child: Icon(Icons.shopping_bag, color: colorsConst[800]),
            onPressed: () => Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: CartMain(cuid: user.uid)))),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: colorsConst[800],
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
                    bottomNaviBtn(Home(), 0, Icons.home, 'HOME'),
                    bottomNaviBtn(
                        OrderProgress(), 1, Icons.fact_check, 'ORDERS'),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    bottomNaviBtn(FAQList(), 2, Icons.question_answer, 'FAQ'),
                    bottomNaviBtn(Profile(), 3, Icons.person, 'PROFILE'),
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
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
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
          Icon(icon,
              color:
                  currentTab == currTab ? Color(0xfffce069) : colorsConst[400]),
          SizedBox(height: 2),
          Text(title,
              style: GoogleFonts.spartan(
                  textStyle: TextStyle(
                      color: currentTab == currTab
                          ? Color(0xfffce069)
                          : colorsConst[400],
                      fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}
