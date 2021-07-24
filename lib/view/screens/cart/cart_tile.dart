import 'package:elok_lagi/controller/database.dart';
import 'package:elok_lagi/models/cart.dart';
import 'package:flutter/material.dart';
import 'package:elok_lagi/view/widgets/constants.dart';

class CartTile extends StatelessWidget {
  final Cart cart;
  double totalPrice;
  CartTile({this.cart, this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            child: (cart.imageURL != null)
                ? Image.network(
                    //! something is wrong with displaying this image AAAAHHH
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
            width: 125,
            height: 125,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(totalPrice.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              Text(cart.name.inCaps,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(height: 4),
              Text('RM ${cart.salePrice.toStringAsFixed(2).toString()}',
                  style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic)),
              SizedBox(height: 4),
              Text('${cart.paxWanted.toString()} pax',
                  style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic)),
              SizedBox(height: 4),
              IconButton(
                alignment: Alignment.bottomRight,
                onPressed: () async {
                  await DatabaseService(uid: cart.cuid, fid: cart.cid)
                      .deleteFoodFromCart();
                },
                iconSize: 30,
                icon: Icon(Icons.delete),
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
