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
    final customer = Provider.of<CustomerData>(context);
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return CustomerTile(customer: customer);
        });
  }
}
