import 'package:elok_lagi/models/users.dart';
import 'package:elok_lagi/view/screens/cart/cart_main.dart';
import 'package:elok_lagi/view/screens/notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ElAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      centerTitle: true,
      title: Text(
        'Elok Lagi',
        style: TextStyle(
          color: Colors.red[400],
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      actions: [
        Stack(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.notifications_none,
                color: Colors.red[400],
                size: 25,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartMain(cuid: user.uid)),
                );
              },
            ),
            Positioned(
              left: 13,
              top: 10,
              child: Container(
                width: 13,
                height: 13,
                decoration: BoxDecoration(
                  color: Colors.red[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: FittedBox(
                  child: Text("7"),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
