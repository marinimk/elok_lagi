import 'package:elok_lagi/view/widgets/constants.dart';
import 'package:elok_lagi/view/widgets/home/restaurant_category_list.dart';
import 'package:flutter/material.dart';
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
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: category.length,
        itemBuilder: (ctx, index) => SizedBox(
          height: 20,
          child: GestureDetector(
            onTap: () => Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.bottomToTop,
                    child: RestaurantCategoryList(category: category[index]))),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 2, color: colorsConstBrown[400]),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Row(
                children: [
                  SizedBox(width: 5),
                  Icon(
                    Icons.fastfood,
                    color: colorsConstBrown[300],
                  ),
                  SizedBox(width: 5),
                  Text(
                    category[index],
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 5),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
