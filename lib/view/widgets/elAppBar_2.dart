import 'package:flutter/material.dart';

class ElAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
