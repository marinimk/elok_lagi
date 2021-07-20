import 'package:elok_lagi/models/users.dart';
import 'package:elok_lagi/controller/auth.dart';
import 'package:elok_lagi/view/widgets/constants.dart';
import 'package:elok_lagi/view/widgets/profile/updateProfile.dart';
import 'package:flutter/material.dart';
import 'package:elok_lagi/controller/database.dart';
import 'package:provider/provider.dart';
import 'package:elok_lagi/models/customer.dart';
import 'package:elok_lagi/view/widgets/profile/customer_list.dart';

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
    final user = Provider.of<Users>(context);
    return StreamProvider<CustomerData>.value(
      value: DatabaseService(uid: user.uid).customerData,
      initialData: CustomerData(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => updateProfileBottomSheet(context),
          child: Icon(Icons.create),
        ),
        body: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              color: colorsConst[100],
              child: Column(
                children: [
                  SizedBox(height: 20),
                  CircleAvatar(
                    radius: 90.0,
                    backgroundImage: AssetImage('assets/images/magik.png'),
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Marini Mustafa Kamal',
                    style: TextStyle(
                        color: colorsConst[900],
                        fontSize: 25,
                        fontWeight: FontWeight.w700),
                  ),
                  ElevatedButton(
                    onPressed: () async => await _auth.signOut(),
                    child: Text('sign out'),
                  ),
                ],
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.4,
                child: CustomerList()),
          ],
        ),
      ),
    );
  }

  Future updateProfileBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                    color: colorsConst[100],
                    border: Border.all(width: 5, color: colorsConst[300]),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                height: 375,
                width: 350,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Update your credentials',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        fontSize: 20),
                  ),
                  SizedBox(height: 10),
                  UpdateProfile(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
