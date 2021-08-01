import 'package:elok_lagi/models/users.dart';
import 'package:elok_lagi/view/screens/cart/cart_main.dart';
import 'package:elok_lagi/view/screens/notifications.dart';
import 'package:elok_lagi/view/widgets/constants.dart';
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
        IconButton(
          icon: Icon(
            Icons.shopping_bag_outlined,
            color: Colors.red[400],
            size: 25,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartMain(cuid: user.uid)),
            );
          },
        )
      ],
    );
  }
}

class ElAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: colorsConstBrown[300],
      ),
      centerTitle: true,
      title: Text(
        'Elok Lagi',
        style: TextStyle(
          color: colorsConstBrown[400],
        ),
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
    );
  }
}
