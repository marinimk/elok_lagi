import 'package:elok_lagi/view/screens/food.dart';
import 'package:flutter/material.dart';
// import 'package:elok_lagi/otherprj/models/products.dart';

class ProductList extends StatelessWidget {
  // final List<Product> foods = [
  // {"name": "Chicken","image" : "assets/images/pic/food8.jpg"},
  // {"name": "Soul","image" : "assets/images/pic/food9.jpg"},
  // {"name": "Fish of US","image" : "assets/images/pic/food7.jpg"},
  // {"name": "Manarish","image" : "assets/images/pic/food6.jpg"},
  //   Product(
  //       name: "Marinara sauce",
  //       image: "assets/images/pic/food6.jpg",
  //       rating: 4.4,
  //       vendor: "Good food",
  //       wishList: true,
  //       price: 500.00),
  //   Product(
  //       name: "Tacos",
  //       image: "assets/images/pic/food7.jpg",
  //       rating: 4.7,
  //       vendor: "Good food",
  //       wishList: true,
  //       price: 500.00),
  //   Product(
  //       name: "Enchilada",
  //       image: "assets/images/pic/food8.jpg",
  //       rating: 4.2,
  //       vendor: "Good food",
  //       wishList: true,
  //       price: 500.00),
  //   Product(
  //       name: "Salsa",
  //       image: "assets/images/pic/food9.jpg",
  //       rating: 4.4,
  //       vendor: "Good food",
  //       wishList: true,
  //       price: 500.00),
  // ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, index) => Container(
          height: 240,
          width: double.infinity,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Food()),
              );
            },
            child: Card(
              shadowColor: Colors.red[200],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
              ),
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                    child: Image.asset(
                      'assets/images/glass.png',
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          index.toString(),
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.w800),
                        ),
                        IconButton(
                            icon: Icon(Icons.favorite_border), onPressed: null)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text("sksksks"),
                            SizedBox(width: 5),
                            Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.red[200],
                            ),
                            Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.red[200],
                            ),
                            Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.red[200],
                            ),
                            Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.red[200],
                            ),
                            Icon(
                              Icons.star_border,
                              size: 14,
                              color: Colors.red[200],
                            )
                          ],
                        ),
                        Text(
                          "ghege ghege",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.red[200],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
