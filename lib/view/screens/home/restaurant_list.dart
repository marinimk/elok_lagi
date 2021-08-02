import 'package:elok_lagi/models/users.dart';
import 'package:elok_lagi/models/restaurant.dart';
import 'package:elok_lagi/controller/database.dart';
import 'package:elok_lagi/view/screens/home/restaurant_info.dart';
import 'package:elok_lagi/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:elok_lagi/view/widgets/constants.dart';

class RestaurantList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder<List<RestaurantData>>(
      stream: DatabaseService(uid: user.uid).restaurant,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<RestaurantData> restaurant = snapshot.data;
          return Container(
            height: 480,
            child: ListView.builder(
              itemCount: restaurant.length,
              itemBuilder: (context, index) => Container(
                height: 225,
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    if (restaurant[index].status)
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.bottomToTop,
                              child: RestaurantInfo(
                                restaurantID: restaurant[index].uid,
                                customerID: user.uid,
                              )));
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
                        Stack(children: [
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
                                            onPressed: null,
                                            child: Row(children: [
                                              Icon(Icons.cancel_outlined,
                                                  color: Colors.white),
                                              SizedBox(width: 5),
                                              Text('CURRENTLY CLOSED',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white))
                                            ]),
                                            style: elevatedButtonStyle()
                                                .copyWith(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all<Color>(Colors
                                                                .black87)))
                                      ]))
                        ]),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                                restaurant[index].name.capitalizeFirstofEach,
                                style: TextStyle(
                                    color: colorsConstBrown[400],
                                    fontSize: 19,
                                    fontWeight: FontWeight.w800))),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(restaurant[index].category,
                                style: TextStyle(fontSize: 16))),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                                restaurant[index]
                                    .location
                                    .capitalizeFirstofEach,
                                style: TextStyle(fontSize: 16))),
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
