import 'package:elok_lagi/controller/database.dart';
import 'package:elok_lagi/models/users.dart';
import 'package:elok_lagi/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:elok_lagi/models/customer.dart';
import 'package:elok_lagi/view/screens/profile/customer_tile.dart';

class CustomerList extends StatefulWidget {
  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);

    return StreamBuilder<CustomerData>(
        stream: DatabaseService(uid: user.uid).customerData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            CustomerData customer = snapshot.data;
            return CustomerTile(customer: customer);
          } else {
            return Loading();
          }
        });
  }
}
