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
            height: 600,
            padding: EdgeInsets.only(bottom: 180),
            child: ListView.builder(
              itemCount: restaurant.length,
              itemBuilder: (context, index) => Container(
                height: 240,
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    print(restaurant[index].uid);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RestaurantInfo(
                                  restaurantID: restaurant[index].uid,
                                  customerID: user.uid,
                                )));
                  },
                  child: Card(
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
                          child: Image.network(
                            restaurant[index].imageURL,
                            width: double.infinity,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(
                            restaurant[index].name.capitalizeFirstofEach,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(restaurant[index].category),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Text(restaurant[index].location),
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
