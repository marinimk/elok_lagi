import 'package:elok_lagi/view/widgets/updateProfile.dart';
import 'package:flutter/material.dart';
import 'package:elok_lagi/models/customer.dart';

class CustomerTile extends StatelessWidget {
  final Customer customer;
  CustomerTile({this.customer});

  @override
  Widget build(BuildContext context) {
    // void _editCustomerInfo(){
    //  showModalBottomSheet(context: context, builder: (context){
    //    return Container(color: Colors.purple,);
    //  });
    // }

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          customerInfoCard(
              context, Icons.person_outline, 'Username', customer.username),
          customerInfoCard(
              context, Icons.email_outlined, 'Email', customer.email),
          customerInfoCard(
              context, Icons.lock_outline, 'Password', customer.password),
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
      margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        // trailing: Icon(Icons.create_outlined),
      ),
    );
  }
}
