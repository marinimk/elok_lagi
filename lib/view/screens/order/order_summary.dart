import 'package:elok_lagi/controller/database.dart';
import 'package:elok_lagi/models/order.dart';
import 'package:elok_lagi/models/users.dart';
import 'package:elok_lagi/view/screens/order/restaurant_order.dart';
import 'package:elok_lagi/view/screens/order/food_order.dart';
import 'package:elok_lagi/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:elok_lagi/view/widgets/constants.dart';
import 'package:provider/provider.dart';

class OrderSummary extends StatefulWidget {
  final String oid;
  // final String cuid;
  OrderSummary(this.oid);

  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder<Order>(
        stream: DatabaseService(uid: user.uid, fid: widget.oid).orderData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Order order = snapshot.data;
            return Scaffold(
              appBar: AppBar(
                title: Text('#${order.oid}'),
              ),
              body: Container(
                // padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    divider(),
                    Expanded(flex: 2, child: RestaurantOrder(ruid: order.ruid)),
                    divider(),
                    Expanded(flex: 5, child: FoodOrder(oid: widget.oid)),
                    divider(),
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Text(
                                          order.message == ''
                                              ? 'No special request'
                                              : order.message,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal)),
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
                    ),
                    divider(),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: elevatedButtonStyle().copyWith(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green),
                            ),
                            onPressed: () {
                              //todo buat dia return to master
                              Navigator.popAndPushNamed(context, '/master');
                            },
                            child: buttonTextRow(Icons.check_circle, 'DONE'),
                          ),
                          // ElevatedButton(
                          //   style: elevatedButtonStyle().copyWith(
                          //     backgroundColor:
                          //         MaterialStateProperty.all<Color>(Colors.red),
                          //   ),
                          //   onPressed: () {
                          //     setState(() => Navigator.pop(context));
                          //   },
                          //   child: buttonTextRow(Icons.cancel, 'CANCEL'),
                          // ),
                        ],
                      ),
                    ),
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
}
