import 'package:elok_lagi/controller/database.dart';
import 'package:elok_lagi/models/order.dart';
import 'package:elok_lagi/models/users.dart';
import 'package:elok_lagi/view/screens/progress/accept/accept_history_list.dart';
import 'package:elok_lagi/view/screens/progress/decline/decline_history_list.dart';
import 'package:elok_lagi/view/screens/progress/pending/pending_list.dart';
import 'package:elok_lagi/view/widgets/constants.dart';
import 'package:elok_lagi/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderProgress extends StatefulWidget {
  @override
  _OrderProgressState createState() => _OrderProgressState();
}

class _OrderProgressState extends State<OrderProgress> {
  int tabbing = 0;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder<List<Order>>(
        stream: DatabaseService(uid: user.uid).order,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                // Expanded(
                //     flex: 1,
                //     child: Container(
                //         padding: EdgeInsets.symmetric(horizontal: 10),
                //         alignment: Alignment.centerLeft,
                //         child: Text('Orders',
                //             style: TextStyle(
                //                 fontSize: 30,
                //                 fontWeight: FontWeight.bold,
                //                 color: colorsConstBrown[600])))),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => tabbing = 0),
                        child: Column(
                          children: [
                            Text(
                              "CURRENT",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: tabbing == 0
                                      ? colorsConstBrown[500]
                                      : colorsConstBrown[300]),
                            ),
                            if (tabbing == 0)
                              Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: colorsConst[800])
                          ],
                        ),
                      ),
                      GestureDetector(
                          onTap: () => setState(() => tabbing = 1),
                          child: Column(children: [
                            Text(
                              "COMPLETED",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: tabbing == 1
                                      ? colorsConstBrown[500]
                                      : colorsConstBrown[300]),
                            ),
                            if (tabbing == 1)
                              Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: colorsConst[800])
                          ])),
                      GestureDetector(
                          onTap: () => setState(() => tabbing = 2),
                          child: Column(children: [
                            Text("DECLINE",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: tabbing == 2
                                        ? colorsConstBrown[500]
                                        : colorsConstBrown[300])),
                            if (tabbing == 2)
                              Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: colorsConst[800])
                          ]))
                    ]),
                if (tabbing == 0)
                  Expanded(child: Container(child: PendingList())),
                if (tabbing == 1)
                  Expanded(child: Container(child: AcceptHistoryList())),
                if (tabbing == 2)
                  Expanded(child: Container(child: DeclineHistoryList()))
              ]),
            );
          } else {
            return Loading();
          }
        });
  }
}
