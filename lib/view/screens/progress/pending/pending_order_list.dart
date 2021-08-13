import 'package:elok_lagi/models/order.dart';
import 'package:elok_lagi/view/screens/progress/pending/pending_order.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class PendingOrderList extends StatefulWidget {
  @override
  _PendingOrderListState createState() => _PendingOrderListState();
}

class _PendingOrderListState extends State<PendingOrderList> {
  @override
  Widget build(BuildContext context) {
    final order = Provider.of<List<Order>>(context);
    return order.length == 0
        ? Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Text(
              'There are no current orders',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black45,
                  fontStyle: FontStyle.italic),
            ),
          )
        : ListView.builder(
            itemCount: order.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child:
                            PendingOrder(order[index].oid, order[index].cuid))),
                child: Card(
                  elevation: 0,
                  color: Colors.yellow[200],
                  margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
                  shape: RoundedRectangleBorder(
                      // side: BorderSide(width: 3, ),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            order[index].pending
                                ? Text('PENDING',
                                    style: TextStyle(
                                        color: Colors.yellow[800],
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600))
                                : order[index].accepted
                                    ? RichText(
                                        text: TextSpan(
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600),
                                          children: [
                                            TextSpan(
                                                text: 'ACCEPTED',
                                                style: TextStyle(
                                                    color: Colors.green)),
                                            order[index].ready
                                                ? TextSpan(
                                                    text: ' & READY',
                                                    style: TextStyle(
                                                        color: Colors.green))
                                                : TextSpan(
                                                    text: ' BUT NOT READY',
                                                    style: TextStyle(
                                                        color: Colors.red)),
                                          ],
                                        ),
                                      )
                                    : Text('DECLINED',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600)),
                            SizedBox(height: 2),
                            Text(order[index].oid,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            SizedBox(height: 2),
                            Text(
                                '${order[index].date} ${order[index].pickUpTime}',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18)),
                          ],
                        ),
                        Icon(Icons.chevron_right, color: Colors.yellow[700]),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
