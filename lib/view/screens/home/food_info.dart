import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:elok_lagi/controller/database.dart';
import 'package:elok_lagi/models/food.dart';
import 'package:elok_lagi/models/users.dart';
import 'package:elok_lagi/view/widgets/constants.dart';
import 'package:elok_lagi/view/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class FoodInfo extends StatefulWidget {
  @override
  _FoodInfoState createState() => _FoodInfoState();

  final String fid;
  final String ruid;
  FoodInfo({this.ruid, this.fid});
}

class _FoodInfoState extends State<FoodInfo> {
  int _pax = 0;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder<Food>(
        stream: DatabaseService(uid: widget.ruid, fid: widget.fid).foodData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final food = snapshot.data;
            int maxPax = food.pax;
            return Container(
              padding: EdgeInsets.only(bottom: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30)),
                      child: Image.network(
                        food.imageURL,
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        // width: 200,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Center(
                          child: Container(
                            width: 200,
                            child: Center(
                              child: Text(
                                food.name.inCaps,
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        priceInfo('Original Price',
                            food.oriPrice.toStringAsFixed(2).toString()),
                        priceInfo('Selling Price',
                            food.oriPrice.toStringAsFixed(2).toString()),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Description',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          food.description,
                          style: TextStyle(fontSize: 16),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RawMaterialButton(
                              onPressed: (_pax == 0)
                                  ? null
                                  : () => setState(() {
                                        do {
                                          _pax--;
                                        } while (_pax < 0);
                                      }),
                              elevation: 1,
                              fillColor: _pax == 0
                                  ? colorsConst[200]
                                  : colorsConst[500],
                              child: Icon(Icons.remove,
                                  size: 25, color: Colors.white),
                              padding: EdgeInsets.all(0.0),
                              shape: CircleBorder(),
                            ),
                            Text(_pax.toString()),
                            RawMaterialButton(
                              onPressed: (_pax == maxPax)
                                  ? null
                                  : () => setState(() {
                                        do {
                                          _pax++;
                                        } while (_pax > maxPax);
                                      }),
                              elevation: 1,
                              fillColor: _pax == maxPax
                                  ? colorsConst[200]
                                  : colorsConst[500],
                              child: Icon(Icons.add,
                                  size: 25, color: Colors.white),
                              padding: EdgeInsets.all(0.0),
                              shape: CircleBorder(),
                            ),
                          ],
                        ),
                        Container(
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_pax == 0) {
                                noPaxEntered(context);
                              } else {
                                await DatabaseService(uid: user.uid)
                                    .isCartEmpty();
                                    
                                bool isFoodIsAlreadyInCart =
                                    await DatabaseService(uid: user.uid)
                                        .isFoodIsAlreadyInCart(food.fid);

                                if (isFoodIsAlreadyInCart) {
                                  itemAddedInCart(context);
                                } else {
                                  await DatabaseService(uid: user.uid)
                                      .addFoodToCart(
                                          widget.fid,
                                          widget.ruid,
                                          food.name,
                                          food.salePrice,
                                          _pax,
                                          food.imageURL);

                                  DatabaseService(
                                          uid: widget.ruid, fid: widget.fid)
                                      .updatePax(maxPax - _pax);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Food saved in cart')));
                                  Navigator.pop(context);
                                }
                              }
                            },
                            child: buttonTextRow(
                                Icons.shopping_bag_outlined, 'Add to cart'),
                            style: elevatedButtonStyle(),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }

  AwesomeDialog noPaxEntered(BuildContext context) {
    return AwesomeDialog(
      context: context,
      borderSide: BorderSide(width: 5, color: colorsConst[100]),
      dialogType: DialogType.INFO,
      animType: AnimType.SCALE,
      body: Container(
          padding: EdgeInsets.fromLTRB(8, 0, 8, 10),
          child: Column(
            children: [
              Text('You did not enter the number of pax you wanted',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              SizedBox(height: 5),
              Container(
                width: 100,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Center(child: buttonTextRow(Icons.check_circle, 'OK')),
                  style: elevatedButtonStyle(),
                ),
              ),
            ],
          )),
      showCloseIcon: true,
    )..show();
  }

  AwesomeDialog itemAddedInCart(BuildContext context) {
    return AwesomeDialog(
      context: context,
      borderSide: BorderSide(width: 5, color: colorsConst[100]),
      dialogType: DialogType.INFO,
      animType: AnimType.SCALE,
      body: Container(
          padding: EdgeInsets.fromLTRB(8, 0, 8, 10),
          child: Column(
            children: [
              Text('Item is already in cart',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
              Text(
                  'If you want to add the number of pax, remove the item in your cart before adding',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400)),
              SizedBox(height: 5),
              Container(
                width: 100,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Center(child: buttonTextRow(Icons.check_circle, 'OK')),
                  style: elevatedButtonStyle(),
                ),
              ),
            ],
          )),
      showCloseIcon: true,
    )..show();
  }

  Align priceInfo(String title, String price) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '-',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
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
                  text: price,
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
    );
  }
}
