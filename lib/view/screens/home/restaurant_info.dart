import 'package:elok_lagi/models/restaurant.dart';
import 'package:elok_lagi/controller/database.dart';
import 'package:elok_lagi/view/screens/home/food_list.dart';
import 'package:elok_lagi/view/widgets/constants.dart';
import 'package:elok_lagi/view/widgets/elAppBar.dart';
import 'package:elok_lagi/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantInfo extends StatefulWidget {
  final String restaurantID;
  final String customerID;
  RestaurantInfo({this.restaurantID, this.customerID});

  @override
  _RestaurantInfoState createState() => _RestaurantInfoState();
}

class _RestaurantInfoState extends State<RestaurantInfo> {
  @override
  Widget build(BuildContext context) {
    var _screenHeight = MediaQuery.of(context).size.height - kToolbarHeight;
    var _screenWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: onWillPop,
      child: StreamBuilder<RestaurantData>(
        initialData: RestaurantData(),
        stream: DatabaseService(uid: widget.restaurantID).restaurantData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            RestaurantData restaurant = snapshot.data;
            return Scaffold(
              appBar: ElAppBar(),
              body: Column(
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: _screenHeight * 0.3,
                      color: colorsConst[100],
                      child:
                          Stack(alignment: Alignment.bottomCenter, children: [
                        Container(color: Colors.white),
                        restaurant.imageURL == null
                            ? Image.asset('assets/images/cat.png',
                                fit: BoxFit.cover,
                                width: _screenWidth,
                                alignment: Alignment.center)
                            : Image.network(restaurant.imageURL,
                                fit: BoxFit.cover,
                                width: _screenWidth,
                                alignment: Alignment.center),
                        Container(
                            padding: EdgeInsets.only(top: 5),
                            width: MediaQuery.of(context).size.width,
                            color: colorsConst[900].withOpacity(0.7),
                            child: Text(restaurant.name.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.spartan(
                                    textStyle: TextStyle(
                                        color: colorsConst[50],
                                        fontSize: 25,
                                        fontWeight: FontWeight.w700)))),
                      ])),
                  Container(
                      height: _screenHeight * 0.65,
                      child: FoodList(restaurantID: widget.restaurantID)),
                ],
              ),
            );
          } else {
            return Loading();
          }
        },
      ),
    );
  }

  Future<bool> onWillPop() async {
    if (await DatabaseService(uid: widget.customerID).isCartEmpty()) {
      return true;
    } else {
      final shouldPop = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('You wanna leave me?'),
          content: Text('Your cart will be empty if you leave :('),
          actions: [
            ElevatedButton(
              onPressed: () async {
                DatabaseService(uid: widget.customerID).deleteCart();
                Navigator.of(context).pop(true);
              },
              child: buttonTextRow(Icons.check_circle, 'Yeap'),
              style: elevatedButtonStyle().copyWith(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: buttonTextRow(Icons.cancel, 'Nahh'),
              style: elevatedButtonStyle().copyWith(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
            ),
          ],
        ),
      );
      return shouldPop ?? false;
    }
  }
}
