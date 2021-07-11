//https://www.youtube.com/watch?v=hgFpcS0e5X0
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:food_delivery_flutter_ui/model/product_model.dart';
// import 'package:food_delivery_flutter_ui/provider/my_provider.dart';
// import 'package:provider/provider.dart';

// import 'card_screen.dart';

class Food extends StatelessWidget {
  // Food(this.itemOfFood);
  Food();

  final itemOfFood = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.black,
        ),
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
                  print('NOTIFICATION presed');
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Notifications()),
                  // );
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
                      borderRadius: BorderRadius.circular(20)),
                  child: FittedBox(
                    child: Text("7"),
                  ),
                ),
              )
            ],
          )
        ],
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                // itemOfFood.pathOfImage,
                'assets/images/magik.png',
                height: 300,
                width: 400,
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // Container(
              //   height: 40,
              //   width: 130,
              //   decoration: BoxDecoration(
              //     color: Color(0xFFF0C143),
              //     borderRadius: BorderRadius.all(
              //       Radius.circular(30),
              //     ),
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
              //     child: Row(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       children: [
              //         GestureDetector(
              //           onTap: () {
              //             // Provider.of<MyProvider>(context, listen: false)
              //             //     .decreaseAmountOfFood();
              //           },
              //           child: Icon(
              //             Icons.remove,
              //             size: 28,
              //             color: Colors.grey[900],
              //           ),
              //         ),
              //         SizedBox(
              //           width: 3,
              //         ),
              //         // Consumer<MyProvider>(
              //         //     builder: (context, numbersOfOrders, child) {
              //         //   return Text(
              //         //     numbersOfOrders.amountOfFood.toString(),
              //         //     style: TextStyle(
              //         //       fontWeight: FontWeight.w600,
              //         //       fontSize: 24,
              //         //       color: Colors.grey[900],
              //         //     ),
              //         //   );
              //         // },),
              //         SizedBox(
              //           width: 3,
              //         ),
              //         GestureDetector(
              //           onTap: () {
              //             // Provider.of<MyProvider>(context, listen: false)
              //             //     .increaseAmountOfFood();
              //           },
              //           child: Icon(
              //             Icons.add,
              //             size: 28,
              //             color: Colors.grey[900],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Center(
                      child: Container(
                        width: 200,
                        child: Center(
                          child: Text(
                            // itemOfFood.describeFood,
                            'sedap bona',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Original price',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              // color: Color(0xFFF4D479),
                            ),
                          ),
                          Text(
                            '-',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              // color: Color(0xFFF4D479),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'RM',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFF4D479),
                                  ),
                                ),
                                TextSpan(
                                  // text: itemOfFood.price,
                                  text: '10',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Selling price',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              // color: Color(0xFFF4D479),
                            ),
                          ),
                          Text(
                            '-',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              // color: Color(0xFFF4D479),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'RM',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFF4D479),
                                  ),
                                ),
                                TextSpan(
                                  // text: itemOfFood.price,
                                  text: '10',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         // itemOfFood.stars,
                  //         'stars',
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.w500, fontSize: 18),
                  //       ),
                  //       SizedBox(
                  //         width: 30,
                  //       ),
                  //       Text(
                  //         // itemOfFood.calories,
                  //         'comel',
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.w500, fontSize: 18),
                  //       ),
                  //       SizedBox(
                  //         width: 30,
                  //       ),
                  //       Text(
                  //         'pantas siswa!!',
                  //         // itemOfFood.time,
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.w500, fontSize: 18),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Details',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      // itemOfFood.details,
                      'sexy as fuck',
                      style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Ingredients',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        // itemOfFood.ingredients,
                        'sugar, spice and everything nice',
                        style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[500]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 32,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
    );
  }
}
