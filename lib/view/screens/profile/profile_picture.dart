import 'package:elok_lagi/controller/auth.dart';
import 'package:elok_lagi/controller/database.dart';
import 'package:elok_lagi/models/customer.dart';
import 'package:elok_lagi/models/users.dart';
import 'package:elok_lagi/view/widgets/constants.dart';
import 'package:elok_lagi/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePicture extends StatefulWidget {
  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder<CustomerData>(
        stream: DatabaseService(uid: user.uid).customerData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            CustomerData customer = snapshot.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 90.0,
                      backgroundImage: NetworkImage(customer.imageURL),
                    ),
                  ],
                ),
                SizedBox(height: 5.0),
                Container(
                  width: 112,
                  child: ElevatedButton(
                    onPressed: () async => await _auth.signOut(),
                    child: buttonTextRow(Icons.logout, 'Logout'),
                    style: elevatedButtonStyle(),
                  ),
                ),
              ],
            );
          } else {
            return Loading();
          }
        });
  }
}
