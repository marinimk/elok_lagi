import 'package:flutter/material.dart';

// import 'package:elok_lagi/otherprj/models/category.dart' as m;

class Category extends StatelessWidget {
  // final List<m.Category> foods = [
  //   m.Category(name: "Beer", image: "assets/images/pic/beer.jpg"),
  //   m.Category(name: "Wine", image: "assets/images/pic/wine.jpg"),
  //   m.Category(name: "Meal", image: "assets/images/pic/meal.jpg"),
  //   m.Category(name: "Fruit", image: "assets/images/pic/fruit.jpg"),
  //   m.Category(name: "Juices", image: "assets/images/pic/drink.jpg"),
  // ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (ctx, index) => SizedBox(
          height: 20,
          child: Card(
            // margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                SizedBox(width: 5),
                Icon(Icons.create),
                SizedBox(width: 5),
                Text('marini pandai sangat sangat'),
                SizedBox(width: 5),
              ],
            ),
          ),
        ),
        // ListTile(
        // leading: Icon(Icons.person),
        // title: Text('Username'),
        // subtitle: Text('marinimk'),
        // trailing: Icon(Icons.create_outlined),
        // ),
      ),
      // ),
      // ),
    );
  }
}
