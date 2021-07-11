import 'package:flutter/material.dart';
import 'package:elok_lagi/models/customer.dart';

class CustomerTile extends StatelessWidget {
  final Customer customer;
  CustomerTile({this.customer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        child: ListTile(
          leading: Icon(Icons.person),
          title: Text('Username'),
          subtitle: Text(customer.username),
          trailing: Icon(Icons.create_outlined),
        ),
      ),
    );
  }
}
