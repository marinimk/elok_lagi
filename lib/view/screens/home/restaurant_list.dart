import 'package:elok_lagi/models/users.dart';
import 'package:elok_lagi/models/restaurant.dart';
import 'package:elok_lagi/controller/database.dart';
import 'package:elok_lagi/view/screens/home/restaurant_info.dart';
import 'package:elok_lagi/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:elok_lagi/view/widgets/constants.dart';
// import 'package:elok_lagi/otherprj/models/products.dart';

//todo: list the restaurants here and not the food
//todo: only display the restaurants that are currently open ( if can :') )
class RestaurantList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    // final restaurant = Provider.of<RestaurantData>(context);
    return StreamBuilder<List<RestaurantData>>(
      stream: DatabaseService(uid: user.uid).restaurant,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<RestaurantData> restaurant = snapshot.data;
          return Container(
            height: 500,
            // padding: EdgeInsets.only(bottom: 180),
            child: ListView.builder(
              itemCount: restaurant.length,
              itemBuilder: (context, index) => Container(
                height: 230,
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    restaurant[index].status
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RestaurantInfo(
                                      restaurantID: restaurant[index].uid,
                                      customerID: user.uid,
                                    )))
                        : print(restaurant[index].status);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20)),
                                child: Image.network(restaurant[index].imageURL,
                                    width: double.infinity,
                                    height: 150,
                                    fit: BoxFit.cover)),
                            restaurant[index].status
                                ? Container()
                                : Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black45.withOpacity(0.3),
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20))),
                                    height: 150,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                              onPressed: () {},
                                              // splashColor: Colors.transparent,
                                              child: buttonTextRow(Icons.close,
                                                  'CURRENTLY CLOSED'),
                                              style: elevatedButtonStyle()
                                                  .copyWith(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.black87),
                                                animationDuration:
                                                    Duration(microseconds: 0),
                                              ))
                                        ]))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                              restaurant[index].name.capitalizeFirstofEach,
                              style: TextStyle(
                                  color: colorsConstBrown[400],
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(restaurant[index].category,
                              style: TextStyle(
                                fontSize: 17,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                              restaurant[index].location.capitalizeFirstofEach,
                              style: TextStyle(
                                fontSize: 17,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
