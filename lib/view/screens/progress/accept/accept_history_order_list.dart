import 'package:elok_lagi/models/history.dart';
import 'package:elok_lagi/view/screens/progress/accept/accept_history_order.dart';
import 'package:elok_lagi/view/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class AcceptHistoryOrderList extends StatefulWidget {
  @override
  _AcceptHistoryOrderListState createState() => _AcceptHistoryOrderListState();
}

class _AcceptHistoryOrderListState extends State<AcceptHistoryOrderList> {
  @override
  Widget build(BuildContext context) {
    final history = Provider.of<List<AcceptHistory>>(context);
    return history.length == 0
        ? Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Text(
              'You must be a new to Elok Lagi since you have no accepted orders. \nSo start browsing the home page and choose whatever you like <3',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black45,
                  fontStyle: FontStyle.italic),
            ),
          )
        : ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: AcceptHistoryOrder(
                            history[index].ahid, history[index].cuid))),
                child: Card(
                  elevation: 0,
                  color: colorsConst[100],
                  margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('COMPLETED',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.green)),
                            SizedBox(height: 2),
                            Text(history[index].ahid,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            SizedBox(height: 2),
                            Text(
                                '${history[index].date} ${history[index].pickUpTime}',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18)),
                          ],
                        ),
                        Icon(Icons.chevron_right, color: colorsConst[400]),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
