import 'package:elok_lagi/controller/database.dart';
import 'package:elok_lagi/models/cart.dart';
import 'package:elok_lagi/models/users.dart';
import 'package:elok_lagi/view/screens/cart/cart_tile.dart';
import 'package:elok_lagi/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:elok_lagi/view/widgets/constants.dart';

class ConfirmOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _screenHeight = MediaQuery.of(context).size.height - kToolbarHeight;
    final user = Provider.of<Users>(context);
    return StreamBuilder<List<Cart>>(
        stream: DatabaseService(uid: user.uid).cartList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final cart = snapshot.data;
            return Container(
              height: _screenHeight * 0.6,
              child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  double totalPrice =
                      cart[index].salePrice * cart[index].paxWanted;
                  return Card(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cart[index].name.inCaps,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            SizedBox(height: 4),
                            Text(
                                'RM ${totalPrice.toStringAsFixed(2).toString()}',
                                style: TextStyle(
                                    fontSize: 15, fontStyle: FontStyle.italic)),
                            SizedBox(height: 4),
                            Text('${cart[index].paxWanted.toString()} pax',
                                style: TextStyle(
                                    fontSize: 15, fontStyle: FontStyle.italic)),
                            SizedBox(height: 4),
                          ],
                        ),
                      ));
                },
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
