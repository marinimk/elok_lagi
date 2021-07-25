import 'package:elok_lagi/controller/database.dart';
import 'package:elok_lagi/models/cart.dart';
import 'package:elok_lagi/models/users.dart';
import 'package:elok_lagi/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:elok_lagi/view/widgets/constants.dart';

class CartList extends StatelessWidget {
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
              height: _screenHeight * 0.80,
              child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  double totalPrice =
                      cart[index].salePrice * cart[index].paxWanted;
                  return Card(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Container(
                        margin: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Container(
                              child: (cart[index].imageURL != null)
                                  ? Image.network(
                                      //! something is wrong with displaying this image AAAAHHH
                                      // cart[index].imageURL,
                                      'https://firebasestorage.googleapis.com/v0/b/elok-lagi.appspot.com/o/1626990863756image_picker7884829982853783093.jpg?alt=media&token=1f0b4b98-f5fa-4ac1-85ce-32e7065039fb',
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.center)
                                  : Image.asset(
                                      'assets/images/nachos.png',
                                      fit: BoxFit.cover,
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.center,
                                    ),
                              width: 80,
                              height: 80,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              flex: 8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(cart[index].name.inCaps,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                  SizedBox(height: 4),
                                  Text(
                                      'RM ${cart[index].salePrice.toStringAsFixed(2).toString()} x ${cart[index].paxWanted.toString()} pax',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic)),
                                  SizedBox(height: 4),
                                  Text(
                                      'RM ${totalPrice.toStringAsFixed(2).toString()}',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold)),
                                  // SizedBox(height: 4),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                // alignment: Alignment.bottomRight,
                                onPressed: () async {
                                  await DatabaseService(
                                          uid: cart[index].cuid,
                                          fid: cart[index].cid)
                                      .deleteFoodFromCart();
                                },
                                iconSize: 30,
                                icon: Icon(Icons.delete),
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      )
                      //CartTile(cart: cart[index], totalPrice:totalPrice),
                      );
                  // double sum = sum + totalPrice;
                },
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
