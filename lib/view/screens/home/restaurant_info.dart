import 'package:elok_lagi/models/restaurant.dart';
import 'package:elok_lagi/controller/database.dart';
import 'package:elok_lagi/view/screens/home/food_list.dart';
import 'package:elok_lagi/view/widgets/constants.dart';
import 'package:elok_lagi/view/widgets/elAppBar.dart';
import 'package:elok_lagi/view/widgets/loading.dart';
import 'package:elok_lagi/view/screens/profile/updateProfile.dart';
import 'package:flutter/material.dart';

class RestaurantInfo extends StatefulWidget {
  final String restaurantID;
  final String customerID;
  RestaurantInfo({this.restaurantID, this.customerID});

  // bool _willPop;

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
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Image.network(
                            restaurant.imageURL,
                            fit: BoxFit.cover,
                            width: _screenWidth,
                            alignment: Alignment.center,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: colorsConst[900].withOpacity(0.5),
                            child: Text(
                              restaurant.name,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: colorsConst[50],
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: _screenHeight * 0.65,
                      child: FoodList(restaurantID: widget.restaurantID),
                    ),
                  ],
                ),
              );
            } else {
              return Loading();
            }
          }),
    );
  }

  Future updateProfileBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                    color: colorsConst[100],
                    border: Border.all(width: 5, color: colorsConst[300]),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                height: 375,
                width: 350,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Update your credentials',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  UpdateProfile(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<bool> onWillPop() async {
    if (await DatabaseService(uid: widget.customerID).isCartEmpty()) {
      return true;
    } else {
      final shouldPop = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Are you sure you want to leave this restaurant?'),
          content: Text('Your cart will be removed if you leave'),
          actions: [
            ElevatedButton(
              onPressed: () async {
                DatabaseService(uid: widget.customerID).deleteCart();
                Navigator.of(context).pop(true);
              },
              child: buttonTextRow(Icons.check_circle, 'Yes'),
              style: elevatedButtonStyle().copyWith(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: buttonTextRow(Icons.cancel, 'Cancel'),
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
