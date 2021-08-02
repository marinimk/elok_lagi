import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:elok_lagi/controller/database.dart';
import 'package:elok_lagi/models/cart.dart';
import 'package:elok_lagi/models/users.dart';
import 'package:elok_lagi/view/screens/cart/cart_content.dart';
import 'package:elok_lagi/view/widgets/constants.dart';
import 'package:elok_lagi/view/widgets/elAppBar.dart';
import 'package:elok_lagi/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class CartMain extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
  final String cuid;
  CartMain({this.cuid});
}

class _CartState extends State<CartMain> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder<List<Cart>>(
      stream: DatabaseService(uid: user.uid).cartList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final cart = snapshot.data;
          return Scaffold(
            appBar: ElAppBar2(),
            body: cart.length == 0
                ? Container(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Text(
                            'Your cart is empty. \nReturn to the Home page to browse the restaurants and add items to your cart',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black45,
                                fontStyle: FontStyle.italic)),
                        SizedBox(height: 10),
                        Container(
                            width: 110,
                            child: ElevatedButton(
                                onPressed: () => Navigator.popAndPushNamed(
                                    context, '/master'),
                                child: buttonTextRow(Icons.home, 'Home'),
                                style: elevatedButtonStyle()))
                      ],
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: CartContent(
                                      cuid: cart[index].cuid,
                                      cid: cart[index].cid,
                                      ruid: cart[index].ruid))),
                          onLongPress: () => deleteCart(context, cart, index),
                          child: Card(
                            color: colorsConst[100],
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 20),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(cart[index].cid,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                          Text(
                                              'Created : ${cart[index].datetime}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontStyle: FontStyle.italic,
                                                  fontSize: 18))
                                        ]),
                                    Icon(Icons.chevron_right,
                                        color: Colors.black38)
                                  ]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          );
        } else {
          return Loading();
        }
      },
    );
  }

  AwesomeDialog deleteCart(BuildContext context, List<Cart> cart, int index) {
    return AwesomeDialog(
      context: context,
      borderSide: BorderSide(width: 5, color: colorsConst[100]),
      dialogType: DialogType.WARNING,
      animType: AnimType.SCALE,
      title: 'Are you sure you want to empty your cart?',
      btnCancelText: 'Cancel',
      btnOkText: 'Yes',
      btnCancelOnPress: () {
        setState(() {});
      },
      btnOkOnPress: () async {
        DatabaseService(uid: cart[index].cuid).deleteCart();
        Navigator.popAndPushNamed(context, '/master');
      },
    )..show();
  }
}
