import 'package:elok_lagi/controller/database.dart';
import 'package:elok_lagi/models/history.dart';
import 'package:elok_lagi/models/users.dart';
import 'package:elok_lagi/view/screens/order/restaurant_order.dart';
import 'package:elok_lagi/view/screens/progress/decline/decline_history_food.dart';
import 'package:elok_lagi/view/widgets/elAppBar.dart';
import 'package:elok_lagi/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:elok_lagi/view/widgets/constants.dart';
import 'package:provider/provider.dart';

class DeclineHistoryOrder extends StatefulWidget {
  final String hid;
  final String cuid;
  DeclineHistoryOrder(this.hid, this.cuid);

  @override
  _DeclineHistoryOrderState createState() => _DeclineHistoryOrderState();
}

class _DeclineHistoryOrderState extends State<DeclineHistoryOrder> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder<DeclineHistory>(
        stream:
            DatabaseService(uid: user.uid, fid: widget.hid).declineHistoryData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            DeclineHistory history = snapshot.data;
            return Scaffold(
              appBar: ElAppBarOrder(title: history.dhid, leading: true),
              body: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    divider(),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.red[300],
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      margin: EdgeInsets.fromLTRB(35, 5, 35, 0),
                      padding: EdgeInsets.fromLTRB(5, 0, 5, 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.error_outline, size: 30),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Order cancelled due to',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Text(history.reason,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: 160,
                        child: RestaurantOrder(ruid: history.ruid)),
                    divider(),
                    Container(
                        height: 275,
                        child: DeclineHistoryFood(hid: history.dhid)),
                    divider(),
                    Container(
                      height: 200,
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
                                Icon(Icons.sticky_note_2, size: 30),
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
                                      height: 75,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          // border: Border.all(
                                          //     width: 2,
                                          //     color: colorsConst[300]),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      child: Text(
                                          history.message == ''
                                              ? 'No special request'
                                              : history.message,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                              fontStyle: history.message == ''
                                                  ? FontStyle.italic
                                                  : FontStyle.normal)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            orderColumn(history, Icons.payment,
                                'Total price: RM ${history.totalPrice.toStringAsFixed(2)}'),
                            SizedBox(height: 5),
                            orderColumn(history, Icons.access_time,
                                'Pick Up Time: ${history.pickUpTime}'),
                          ],
                        ),
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

  Row orderColumn(DeclineHistory history, IconData icon, String info) {
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
