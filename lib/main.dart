import 'package:elok_lagi/master.dart';
import 'package:elok_lagi/services/auth.dart';
import 'package:elok_lagi/view/screens/home.dart';
import 'package:elok_lagi/view/screens/profile.dart';
import 'package:elok_lagi/view/wrapper.dart';
import 'package:elok_lagi/view/authenthicate/signinup.dart';
import 'package:elok_lagi/models/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

// void main() {
//   runApp(MyApp());
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return StreamProvider<Users>.value(
      initialData: Users(),
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Wrapper(),
      ),
    );
  }
}
