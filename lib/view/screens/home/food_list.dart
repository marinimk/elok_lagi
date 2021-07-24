import 'package:elok_lagi/models/food.dart';
import 'package:elok_lagi/view/screens/home/food_info.dart';
import 'package:elok_lagi/view/screens/home/food_tile.dart';
import 'package:elok_lagi/view/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:elok_lagi/controller/database.dart';

class FoodList extends StatefulWidget {
  @override
  _FoodListState createState() => _FoodListState();
  final String restaurantID;
  FoodList({this.restaurantID});
}

//Todo: this screen is going to be a combo of restaurant and food
//todo: restaurant is to display it's information
//todo: food is to get all

class _FoodListState extends State<FoodList> {
  @override
  Widget build(BuildContext context) {
    var _screenHeight = MediaQuery.of(context).size.height - kToolbarHeight;
    return StreamBuilder<List<Food>>(
        stream: DatabaseService(uid: widget.restaurantID).food,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final food = snapshot.data;
            return Scaffold(
              body: Container(
                height: _screenHeight * 0.7,
                child: ListView.builder(
                  itemCount: food.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        updateProfileBottomSheet(context, food, index);
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => ));
                      },
                      child: Card(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: FoodTile(food: food[index])),
                    );
                  },
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }

  Future updateProfileBottomSheet(
      BuildContext context, List<Food> food, int index) {
    return showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      // isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: FoodInfo(ruid: widget.restaurantID, fid: food[index].fid));
      },
    );
  }
}
