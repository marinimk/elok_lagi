import 'package:elok_lagi/master.dart';
import 'package:elok_lagi/models/users.dart';
import 'package:elok_lagi/view/authenticate/authenticate.dart';
// import 'package:elok_lagi/screens/home.dart';
import 'package:elok_lagi/view/authenticate/signinup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Master();
    }
    // return Authenticate();
  }
}
