import 'package:elok_lagi/controller/database.dart';
import 'package:elok_lagi/master.dart';
import 'package:elok_lagi/models/cart.dart';
import 'package:elok_lagi/models/users.dart';
import 'package:elok_lagi/view/screens/cart/cart_content.dart';
import 'package:elok_lagi/view/widgets/constants.dart';
import 'package:elok_lagi/view/widgets/elAppBar.dart';
import 'package:elok_lagi/view/widgets/loading.dart';
import 'package:flutter/material.dart';
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
            appBar: ElAppBar(),
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
                              fontStyle: FontStyle.italic),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 105,
                          child: ElevatedButton(
                            onPressed: () => Navigator.popAndPushNamed(
                                context, '/master.dart'),
                            child: buttonTextRow(Icons.home, 'Home'),
                            style: elevatedButtonStyle(),
                          ),
                        )
                      ],
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CartContent(
                                          cuid: cart[index].cuid,
                                          cid: cart[index].cid,
                                          ruid: cart[index].ruid)));
                            },
                            child: Card(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: ListTile(
                                  //todo: maybe instead of the cid, letak the datetime of when the cart was made.
                                  title: Text('cart main : ${cart[index].cid}'),
                                )));
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
}
