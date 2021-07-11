import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elok_lagi/models/users.dart';
import 'package:elok_lagi/services/auth.dart';
import 'package:elok_lagi/view/widgets/customer_tile.dart';
import 'package:flutter/material.dart';
import 'package:elok_lagi/services/database.dart';
import 'package:provider/provider.dart';
import 'package:elok_lagi/models/customer.dart';

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
        body: Container(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.deepPurple[800],
                            Colors.deepPurpleAccent
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          CircleAvatar(
                            radius: 50.0,
                            backgroundImage:
                                AssetImage('assets/images/cat.png'),
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
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      // color: Colors.grey[200],
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Column(
                          children: [
                            Text(
                              'Information',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            CustomerTile(),
                            // CustomerTile(),
                            // Card(
                            //   child: ListTile(
                            //     leading: Icon(Icons.person),
                            //     title: Text('Username'),
                            //     subtitle: Text(''),
                            //     trailing: Icon(Icons.create_outlined),
                            //   ),
                            // ),
                            // Card(
                            //   child: ListTile(
                            //     leading: Icon(Icons.email),
                            //     title: Text('Email'),
                            //     subtitle: Text('marinimustafakamal@gmail.com'),
                            //     trailing: Icon(Icons.create_outlined),
                            //   ),
                            // ),
                            // Card(
                            //   child: ListTile(
                            //     leading: Icon(Icons.lock),
                            //     title: Text('Password'),
                            //     subtitle: Text('*********'),
                            //     trailing: Icon(Icons.create_outlined),
                            //   ),
                            // ),
                            // Card(
                            //   child: ListTile(
                            //     leading: Icon(Icons.phone_android),
                            //     title: Text('Phone Number'),
                            //     subtitle: Text('017-340 3154'),
                            //     trailing: Icon(Icons.create_outlined),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
