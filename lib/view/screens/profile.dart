import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elok_lagi/models/users.dart';
import 'package:elok_lagi/services/auth.dart';
import 'package:elok_lagi/view/widgets/customer_tile.dart';
import 'package:elok_lagi/view/widgets/updateProfile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:elok_lagi/services/database.dart';
import 'package:provider/provider.dart';
import 'package:elok_lagi/models/customer.dart';
import 'package:elok_lagi/view/widgets/customer_list.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
  final Customer customer;
  Profile({this.customer});
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Customer>>.value(
      value: DatabaseService().customer,
      initialData: [],
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.amber,
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage('assets/images/cat.png'),
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      'Marini Mustafa Kamal',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      'Bronze member',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await _auth.signOut();
                      },
                      child: Text('sign out'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                            // isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 30, horizontal: 50),
                                child: Column(
                                  // color: Colors.purple,
                                  children: [
                                    Text(
                                      'Update your credentials',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    UpdateProfile(),
                                    // UpdateProfile(icon, title, subtitle),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Text('Edit profile'),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              // width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              child: CustomerList(),
            ),
          ],
        ),
      ),
    );
  }
}
