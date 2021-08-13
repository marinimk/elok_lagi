import 'package:elok_lagi/controller/database.dart';
import 'package:elok_lagi/models/order.dart';
import 'package:elok_lagi/models/users.dart';
import 'package:elok_lagi/view/screens/progress/pending/pending_order_list.dart';
import 'package:elok_lagi/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PendingList extends StatefulWidget {
  @override
  _HistoryList createState() => _HistoryList();
}

class _HistoryList extends State<PendingList> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return loading
        ? Loading()
        : StreamProvider<List<Order>>.value(
            value: DatabaseService(uid: user.uid).order,
            initialData: [],
            child: Container(height: 500, child: PendingOrderList()));
  }
}
