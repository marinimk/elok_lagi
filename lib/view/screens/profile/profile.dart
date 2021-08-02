import 'package:elok_lagi/models/users.dart';
import 'package:elok_lagi/controller/auth.dart';
import 'package:elok_lagi/view/screens/profile/profile_picture.dart';
import 'package:elok_lagi/view/widgets/constants.dart';
import 'package:elok_lagi/view/screens/profile/updateProfile.dart';
import 'package:elok_lagi/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:elok_lagi/controller/database.dart';
import 'package:provider/provider.dart';
import 'package:elok_lagi/models/customer.dart';
import 'package:elok_lagi/view/screens/profile/customer_list.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
  final Customer customer;
  Profile({this.customer});
}

class _ProfileState extends State<Profile> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.bottom -
        kToolbarHeight;
    final user = Provider.of<Users>(context);
    return loading
        ? Loading()
        : StreamProvider<CustomerData>.value(
            value: DatabaseService(uid: user.uid).customerData,
            initialData: CustomerData(),
            child: Scaffold(
              floatingActionButton: FloatingActionButton(
                backgroundColor: Color(0xfffce069),
                elevation: 0,
                onPressed: () => updateProfileBottomSheet(context),
                child: Icon(Icons.create, color: colorsConst[800]),
              ),
              body: Column(
                children: <Widget>[
                  Stack(children: [
                    Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/daun_transparent.png"),
                                fit: BoxFit.cover)),
                        width: MediaQuery.of(context).size.width,
                        height: h * 0.35),
                    Container(
                        color: Colors.white.withOpacity(0.3),
                        width: MediaQuery.of(context).size.width,
                        height: h * 0.35),
                    Container(
                        child: Center(child: ProfilePicture()),
                        width: MediaQuery.of(context).size.width,
                        height: h * 0.35),
                  ]),
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
                    // border: Border.all(width: 5, color: colorsConst[300]),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                height: 500,
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
