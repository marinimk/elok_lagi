import 'package:elok_lagi/view/widgets/constants.dart';
import 'package:elok_lagi/view/widgets/home/restaurant_category_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

// import 'package:elok_lagi/otherprj/models/category.dart' as m;

class Category extends StatelessWidget {
  final List<String> category = [
    'Western Food',
    'Malaysian Food',
    'Fusion',
    'Italian',
    'Desserts',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      // padding: EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 5),
        scrollDirection: Axis.horizontal,
        itemCount: category.length,
        itemBuilder: (ctx, index) => SizedBox(
          child: GestureDetector(
            onTap: () => Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: RestaurantCategoryList(category: category[index]))),
            child: Card(
              color: Color(0xfffdeb9b),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Text(
                    category[index],
                    style: GoogleFonts.lustria(
                        textStyle: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
