// import 'package:elok_lagi/view/authenticate/signin.dart';
import 'package:elok_lagi/view/authenticate/signinup.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SignInUp(),
    );
  }
}
