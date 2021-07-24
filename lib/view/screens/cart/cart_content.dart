import 'package:elok_lagi/controller/database.dart';
import 'package:elok_lagi/models/restaurant.dart';
import 'package:elok_lagi/models/users.dart';
import 'package:elok_lagi/view/screens/cart/cart_list.dart';
import 'package:elok_lagi/view/screens/order/confirm_order.dart';
import 'package:elok_lagi/view/widgets/constants.dart';
import 'package:elok_lagi/view/widgets/elAppBar.dart';
import 'package:elok_lagi/view/widgets/loading.dart';
import 'package:elok_lagi/view/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartContent extends StatefulWidget {
  final String cuid;
  final String cid;
  final String ruid;
  CartContent({this.cuid, this.cid, this.ruid});

  @override
  _CartContentState createState() => _CartContentState();
}

class _CartContentState extends State<CartContent> {
  final _formKey = GlobalKey<FormState>();

  String _pickUpTime;
  String _message;

  final List<String> time = [
    '15',
    '30',
    '45',
    '60',
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    Size _screenSize = MediaQuery.of(context).size;
    return StreamBuilder<RestaurantData>(
      stream: DatabaseService(uid: widget.ruid).restaurantData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final restaurant = snapshot.data;
          return Scaffold(
            appBar: ElAppBar(),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              // height: _screenSize.height * 0.2,
              child: Column(
                children: [
                  restaurantInfoInCart(Icons.house, restaurant.name),
                  divider(),
                  restaurantInfoInCart(
                      Icons.phone_android, restaurant.phoneNum),
                  divider(),
                  restaurantInfoInCart(Icons.pin_drop, restaurant.location),
                  // SizedBox(height: 10),
                  CartList(),
                ],
              ),
            ),
            floatingActionButton: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: FloatingActionButton.extended(
                  elevation: 0,
                  label:
                      buttonTextRow(Icons.shopping_bag_outlined, 'Place Order'),
                  onPressed: () async {
                    print(await DatabaseService(uid: user.uid)
                        .calcCartTotalPrice());
                    updateProfileBottomSheet(
                        context,
                        restaurant,
                        user.uid,
                        await DatabaseService(uid: user.uid)
                            .calcCartTotalPrice());
                  }),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
        } else {
          return Loading();
        }
      },
    );
  }

  Future updateProfileBottomSheet(BuildContext context,
      RestaurantData restaurant, String cuid, double totalPrice) {
    Size _screenSize = MediaQuery.of(context).size;
    return showModalBottomSheet(
      // isDismissible: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: _screenSize.height,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colorsConst[300],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(restaurant.imageURL),
                    ),
                    SizedBox(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.house),
                            Text(restaurant.name.inCaps,
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.money),
                            Text('RM ${totalPrice.toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.fromLTRB(30, 15, 30, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      pickupTimeDropDown(),
                      updateTextFormField(
                          Icons.border_color, 'Special request'),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Column(
                  children: [
                    ConfirmOrder(),
                    // SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: ElevatedButton(
                            style: elevatedButtonStyle().copyWith(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green),
                            ),
                            onPressed: () async {
                              await DatabaseService(uid: cuid)
                                  .createOrderCustomer(cuid, restaurant.uid,
                                      _message, _pickUpTime, totalPrice);

                              await DatabaseService(uid: restaurant.uid, fid: cuid)
                                  .createOrderMerchant(cuid, restaurant.uid,
                                      _message, _pickUpTime, totalPrice);

                              Navigator.pop(context);
                            },
                            child: buttonTextRow(Icons.check_circle, 'CONFIRM'),
                          ),
                        ),
                        SizedBox(width: 5),
                        Container(
                          child: ElevatedButton(
                            style: elevatedButtonStyle().copyWith(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: buttonTextRow(Icons.cancel, 'CANCEL'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Padding updateTextFormField(IconData icon, String title) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
          // initialValue: initVal,
          // validator: (val) => val.isEmpty
          //     ? 'please field in your new $widget.title.toLowerCase()'
          //     : '',
          onChanged: (val) => setState(() => _message = val),
          decoration: textInputDecoration(icon, title)),
    );
  }

  DropdownButtonFormField pickupTimeDropDown() {
    return DropdownButtonFormField(
      decoration: textInputDecoration(Icons.access_time, null).copyWith(),
      hint: Text('Please select a pick up time'),
      items: time.map((t) {
        return DropdownMenuItem(
          value: t,
          child: t == '60' ? Text('1 hour') : Text('${t.toString()} minutes'),
        );
      }).toList(),
      onChanged: (val) {
        setState(() {
          _pickUpTime = val;
        });
      },
    );
  }

  Divider divider() {
    return Divider(thickness: 2, height: 4);
  }

  Container restaurantInfoInCart(IconData icon, String restaurantInfo) {
    return Container(
        color: colorsConst[100],
        padding: EdgeInsets.all(2),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(icon),
          Text(
            restaurantInfo,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          )
        ]));
  }
}
