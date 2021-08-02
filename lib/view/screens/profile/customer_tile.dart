import 'package:elok_lagi/view/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:elok_lagi/models/customer.dart';

class CustomerTile extends StatelessWidget {
  final CustomerData customer;
  CustomerTile({this.customer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          customerInfoCard(context, Icons.person_outline, 'Username',
              customer.username.capitalizeFirstofEach),
          customerInfoCard(
              context, Icons.pin_drop_outlined, 'Location', customer.location),
          customerInfoCard(context, Icons.phone_android_outlined,
              'Phone Number', customer.phoneNum),
        ],
      ),
    );
  }

  Card customerInfoCard(
      BuildContext context, IconData icon, String title, String subtitle) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 3, color: colorsConstBrown[400]),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      margin: EdgeInsets.fromLTRB(20, 6, 20, 6),
      child: ListTile(
        leading: Icon(icon, size: 35, color: colorsConstBrown[600]),
        title: Text(title,
            style: TextStyle(
                color: colorsConstBrown[700],
                fontSize: 17,
                fontWeight: FontWeight.w600)),
        subtitle: Text(
          subtitle,
          style: TextStyle(
              color: Colors.black87, fontSize: 16, fontStyle: FontStyle.italic),
        ),
      ),
    );
  }
}
