import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:elok_lagi/controller/database.dart';
import 'package:elok_lagi/models/order.dart';
import 'package:elok_lagi/models/users.dart';
import 'package:elok_lagi/view/screens/order/restaurant_order.dart';
import 'package:elok_lagi/view/screens/order/food_order.dart';
import 'package:elok_lagi/view/widgets/elAppBar.dart';
import 'package:elok_lagi/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:elok_lagi/view/widgets/constants.dart';
import 'package:provider/provider.dart';

class PendingOrder extends StatefulWidget {
  final String hid;
  final String cuid;
  PendingOrder(this.hid, this.cuid);

  @override
  _PendingOrderState createState() => _PendingOrderState();
}

class _PendingOrderState extends State<PendingOrder> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder<Order>(
        stream: DatabaseService(uid: user.uid, fid: widget.hid).orderData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Order order = snapshot.data;
            return Scaffold(
              appBar: ElAppBarOrder(title: order.oid, leading: true),
              body: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    divider(),
                    Container(
                        height: 160, child: RestaurantOrder(ruid: order.ruid)),
                    divider(),
                    Container(height: 290, child: FoodOrder(oid: order.oid)),
                    divider(),
                    Container(
                      height: 175,
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(Icons.border_color, size: 30),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Special request: ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    width: 275,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 2, color: colorsConst[300]),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    child: Text(
                                        order.message == ''
                                            ? 'No special request'
                                            : order.message,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            fontStyle: order.message == ''
                                                ? FontStyle.italic
                                                : FontStyle.normal)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          orderColumn(order, Icons.payment,
                              'Total price: RM ${order.totalPrice.toStringAsFixed(2)}'),
                          SizedBox(height: 5),
                          orderColumn(order, Icons.access_time,
                              'Pick Up Time: ${order.pickUpTime}'),
                        ],
                      ),
                    ),
                    divider(),
                    Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: elevatedButtonStyle().copyWith(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green),
                              ),
                              onPressed: () async {
                                if (order.ready) {
                                  await DatabaseService(
                                          uid: user.uid, fid: order.oid)
                                      .createHistoryFromAccept();
                                  await DatabaseService(
                                          uid: user.uid,
                                          ruid: order.ruid,
                                          fid: widget.hid)
                                      .completeOrderRestaurant();
                                  Navigator.of(context).pop();
                                } else
                                  orderNotReady(context);
                              },
                              child:
                                  buttonTextRow(Icons.check_circle, 'PICK UP'),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }

  Row orderColumn(Order order, IconData icon, String info) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon, size: 30),
        SizedBox(width: 10),
        Text(info, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Divider divider() {
    return Divider(thickness: 1, height: 1);
  }

  AwesomeDialog orderNotReady(BuildContext context) {
    return AwesomeDialog(
      context: context,
      borderSide: BorderSide(width: 5, color: colorsConst[100]),
      dialogType: DialogType.INFO_REVERSED,
      animType: AnimType.SCALE,
      title: 'Your order is not ready yet',
      desc: 'Chill babe.. it\'ll be ready in a sec',
      btnOkText: 'Oh okayy',
      btnCancel: null,
      btnOkOnPress: () async => Navigator.of(context).pop(),
    )..show();
  }
}
