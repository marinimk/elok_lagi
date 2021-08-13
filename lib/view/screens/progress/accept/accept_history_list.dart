import 'package:elok_lagi/controller/database.dart';
import 'package:elok_lagi/models/history.dart';
import 'package:elok_lagi/models/users.dart';
import 'package:elok_lagi/view/screens/progress/accept/accept_history_order_list.dart';
import 'package:elok_lagi/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AcceptHistoryList extends StatefulWidget {
  @override
  _HistoryList createState() => _HistoryList();
}

class _HistoryList extends State<AcceptHistoryList> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return loading
        ? Loading()
        : StreamProvider<List<AcceptHistory>>.value(
            value: DatabaseService(uid: user.uid).acceptHistory,
            initialData: [],
            child: Container(height: 500, child: AcceptHistoryOrderList()));
  }
}
