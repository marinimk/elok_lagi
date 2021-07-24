import 'package:elok_lagi/view/screens/home/food_info.dart';
import 'package:flutter/material.dart';
// import 'package:elok_lagi/otherprj/models/products.dart';

class Featured extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (ctx, index) => Container(
                height: 240,
                width: 200,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FoodInfo()),
                    );
                  },
                  child: Card(
                    shadowColor: Colors.red[200],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10))),
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                          child: Image.asset(
                            'assets/images/magik.png',
                            width: 200,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // Text(foods[index].name,style:TextStyle(color:Colors.grey,fontSize: 16,fontWeight: FontWeight.w800)),
                              IconButton(
                                  icon: Icon(Icons.favorite_border),
                                  onPressed: null)
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
                                  Text("hi apa ni?"),
                                  // Text("${foods[index].rating}"),
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
                                // "MMK ${foods[index].price.toStringAsFixed(0)}",
                                "rm 10",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.red[200]),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )),
    );
  }
}
