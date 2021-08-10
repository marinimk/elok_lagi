import 'package:elok_lagi/models/users.dart';
import 'package:elok_lagi/view/screens/cart/cart_main.dart';
import 'package:elok_lagi/view/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class ElAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return AppBar(
      iconTheme: IconThemeData(color: colorsYellowBanan),
      centerTitle: true,
      title: Text('ELOK LAGI',
          style: GoogleFonts.spartan(
              textStyle: TextStyle(
                  color: colorsYellowBanan,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 10))),
      backgroundColor: colorsConst[800],
      elevation: 0.0,
      actions: [
        IconButton(
            icon: Icon(Icons.shopping_bag_outlined,
                color: colorsYellowBanan, size: 25),
            onPressed: () => Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: CartMain(cuid: user.uid))))
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
      automaticallyImplyLeading: false,
      iconTheme: IconThemeData(color: colorsYellowBanan),
      centerTitle: true,
      title: Text('ELOK LAGI',
          style: GoogleFonts.spartan(
              textStyle: TextStyle(
                  color: colorsYellowBanan,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 10))),
      backgroundColor: colorsConst[800],
      elevation: 0.0,
    );
  }
}

class ElAppBarOrder extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  final String title;
  final bool leading;
  ElAppBarOrder({this.title, this.leading});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: leading,
      iconTheme: IconThemeData(color: colorsYellowBanan),
      centerTitle: true,
      title: Text('#$title',
          style: GoogleFonts.spartan(
              textStyle: TextStyle(
                  color: colorsYellowBanan,
                  fontWeight: FontWeight.w600,
                  fontSize: 18))),
      backgroundColor: colorsConst[800],
      elevation: 0.0,
    );
  }
}
