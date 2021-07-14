import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:elok_lagi/models/customer.dart';
import 'package:elok_lagi/view/widgets/customer_tile.dart';

class CustomerList extends StatefulWidget {
  @override
  CustomerListState createState() => CustomerListState();
}

class CustomerListState extends State<CustomerList> {
  @override
  Widget build(BuildContext context) {
    final customer = Provider.of<List<Customer>>(context);
    return ListView.builder(
      itemCount: customer.length,
      itemBuilder: (context, index) {
        return CustomerTile(customer: customer[index]);
      },
    );
  }
}
