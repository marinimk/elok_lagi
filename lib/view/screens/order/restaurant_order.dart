import 'package:elok_lagi/controller/database.dart';
import 'package:elok_lagi/models/restaurant.dart';
import 'package:elok_lagi/view/widgets/constants.dart';
import 'package:flutter/material.dart';

class RestaurantOrder extends StatelessWidget {
  final String ruid;
  RestaurantOrder({this.ruid});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RestaurantData>(
        stream: DatabaseService(uid: ruid).restaurantData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final restaurant = snapshot.data;
            return Column(
              children: [
                restaurantInfo(
                    Icons.person, 'Restaurant Name', restaurant.name),
                restaurantInfo(Icons.phone_android, 'Restaurant Phone Number',
                    restaurant.phoneNum),
                restaurantInfo(
                    Icons.pin_drop, 'Restaurant Location', restaurant.location)
              ],
            );
          } else {
            return Container();
          }
        });
  }

  Container restaurantInfo(IconData icon, String title, String info) {
    return Container(
      padding: EdgeInsets.fromLTRB(40, 5, 40, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, size: 30),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Text(
                info.capitalizeFirstofEach,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
