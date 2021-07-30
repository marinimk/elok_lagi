import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elok_lagi/models/cart.dart';
import 'package:elok_lagi/models/customer.dart';
import 'package:elok_lagi/models/faq.dart';
import 'package:elok_lagi/models/food.dart';
import 'package:elok_lagi/models/fooditem.dart';
import 'package:elok_lagi/models/history.dart';
import 'package:elok_lagi/models/order.dart';
import 'package:elok_lagi/models/restaurant.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DatabaseService {
  final String uid;
  final String fid;
  final String ruid;
  final String cid;
  DatabaseService({@required this.uid, this.fid, this.ruid, this.cid});

  // collection reference
  final CollectionReference customerCollection =
      FirebaseFirestore.instance.collection('customer');
  final CollectionReference restaurantCollection =
      FirebaseFirestore.instance.collection('restaurant');
  final CollectionReference faqCollection =
      FirebaseFirestore.instance.collection('faqCustomer');

  //CRU the customer's information
  Future updateCustomerData(String username, String location, String phoneNum,
      String imageURL) async {
    return await customerCollection.doc(uid).set({
      'uid': uid,
      'username': username,
      'location': location,
      'phoneNum': phoneNum,
      'imageURL': imageURL,
    });
  }

  //customer list from snapshot that i dont think i'll be using
  List<Customer> _customerListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Customer(
        username: doc.data()['username'] ?? '',
        location: doc.data()['location'] ?? '',
        phoneNum: doc.data()['phoneNum'] ?? '',
        imageURL: doc.data()['imageURL'] ?? '',
      );
    }).toList();
  }

  Stream<List<Customer>> get customer {
    return customerCollection.snapshots().map(_customerListFromSS);
  }

  //customer data from snapshot
  CustomerData _customerDataFromSS(DocumentSnapshot snapshot) {
    return CustomerData(
      uid: uid,
      username: snapshot.data()['username'] ?? '',
      location: snapshot.data()['location'] ?? '',
      phoneNum: snapshot.data()['phoneNum'] ?? '',
      imageURL: snapshot.data()['imageURL'] ?? '',
    );
  }

  Stream<CustomerData> get customerData {
    return customerCollection.doc(uid).snapshots().map(_customerDataFromSS);
  }

  //getting the list of restaurants to be displayed in home.dart
  List<RestaurantData> _restaurantListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return RestaurantData(
        uid: doc.data()['uid'] ?? '',
        name: doc.data()['name'] ?? '',
        category: doc.data()['category'] ?? '',
        location: doc.data()['location'] ?? '',
        phoneNum: doc.data()['phoneNum'] ?? '',
        status: doc.data()['status'] ?? false,
        imageURL: doc.data()['imageURL'] ?? '',
      );
    }).toList();
  }

  Stream<List<RestaurantData>> get restaurant {
    return restaurantCollection.snapshots().map(_restaurantListFromSS);
  }

  //getting the restaurant that the customer clicks on to display its info
  RestaurantData _restaurantDataFromSS(DocumentSnapshot snapshot) {
    return RestaurantData(
      uid: snapshot.data()['uid'] ?? '',
      name: snapshot.data()['name'] ?? '',
      category: snapshot.data()['category'] ?? '',
      location: snapshot.data()['location'] ?? '',
      phoneNum: snapshot.data()['phoneNum'] ?? '',
      status: snapshot.data()['status'] ?? false,
      imageURL: snapshot.data()['imageURL'] ?? '',
    );
  }

  Stream<RestaurantData> get restaurantData {
    return restaurantCollection.doc(uid).snapshots().map(_restaurantDataFromSS);
  }

  //getting the list food in the restaurant
  List<Food> _foodListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Timestamp dtTS = doc.data()['datetime'] as Timestamp;
      DateTime dtDT = dtTS.toDate();
      String date =
          '${dtDT.day.toString().padLeft(2, '0')}/${dtDT.month.toString().padLeft(2, '0')}/${dtDT.year.toString().padLeft(2, '0')}';

      String datetime = '$date ${DateFormat('jm').format(dtDT)}';

      return Food(
        fid: doc.data()['fid'] ?? '',
        name: doc.data()['name'] ?? '',
        description: doc.data()['description'] ?? '',
        oriPrice: doc.data()['oriPrice'] ?? 0.0,
        salePrice: doc.data()['salePrice'] ?? 0.0,
        datetime: datetime ?? '00/00/0000 00.00',
        pax: doc.data()['pax'] ?? 0,
        imageURL: doc.data()['imageURL'] ?? '',
      );
    }).toList();
  }

  Stream<List<Food>> get food {
    return restaurantCollection
        .doc(uid)
        .collection('food')
        .orderBy('datetime', descending: true)
        .snapshots()
        .map(_foodListFromSS);
  }

  //returning a single food item int
  Food _foodDataFromSS(DocumentSnapshot snapshot) {
    Timestamp dtTS = snapshot.data()['datetime'] as Timestamp;
    DateTime dtDT = dtTS.toDate();
    String date =
        '${dtDT.day.toString().padLeft(2, '0')}/${dtDT.month.toString().padLeft(2, '0')}/${dtDT.year.toString().padLeft(2, '0')}';

    String datetime = '$date ${DateFormat('jm').format(dtDT)}';

    return Food(
      fid: snapshot.data()['fid'] ?? '',
      name: snapshot.data()['name'] ?? '',
      description: snapshot.data()['description'] ?? '',
      oriPrice: snapshot.data()['oriPrice'] ?? 0.0,
      salePrice: snapshot.data()['salePrice'] ?? 0.0,
      datetime: datetime ?? '00/00/0000 00.00',
      pax: snapshot.data()['pax'] ?? 0,
      imageURL: snapshot.data()['imageURL'] ?? '',
    );
  }

  Stream<Food> get foodData {
    return restaurantCollection
        .doc(uid)
        .collection('food')
        .doc(fid)
        .snapshots()
        .map(_foodDataFromSS);
  }

  //returning the list of faq in a restaurant
  List<FAQ> _faqListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FAQ(
        faqid: doc.data()['faqid'] ?? '',
        question: doc.data()['question'] ?? '',
        answer: doc.data()['answer'] ?? '',
      );
    }).toList();
  }

  Stream<List<FAQ>> get faqList {
    return faqCollection.snapshots().map(_faqListFromSS);
  }

  //returning a single faq
  FAQ _faqDataFromSS(DocumentSnapshot snapshot) {
    return FAQ(
      faqid: snapshot.data()['faqid'] ?? '',
      question: snapshot.data()['question'] ?? '',
      answer: snapshot.data()['answer'] ?? '',
    );
  }

  Stream<FAQ> get faq {
    return faqCollection.doc(uid).snapshots().map(_faqDataFromSS);
  }

  //adding items into cart
  Future addFoodToCart(String fid, String ruid, String name, double salePrice,
      int paxWanted, String imageURL) async {
    var newCartDoc = customerCollection.doc(uid).collection('cart').doc();
    return await newCartDoc.set({
      'cid': newCartDoc.id,
      'cuid': uid,
      'fid': fid,
      'ruid': ruid,
      'name': name,
      'salePrice': salePrice,
      'paxWanted': paxWanted,
      'imageURL': imageURL,
      'datetime': DateTime.now(),
    });
  }

  //returning the list of items in the cart
  List<Cart> _cartListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Timestamp dt = doc.data()['datetime'] as Timestamp;
      DateTime daTi = dt.toDate();

      String dateTime =
          '${daTi.day.toString().padLeft(2, '0')}/${daTi.month.toString().padLeft(2, '0')}/${daTi.year.toString().padLeft(2, '0')} ${DateFormat('jm').format(daTi)}';
      return Cart(
        cid: doc.data()['cid'] ?? '',
        cuid: doc.data()['cuid'] ?? '',
        fid: doc.data()['fid'] ?? '',
        ruid: doc.data()['ruid'] ?? '',
        name: doc.data()['name'] ?? '',
        salePrice: doc.data()['salePrice'] ?? 0.0,
        paxWanted: doc.data()['paxWanted'] ?? 0,
        imageURL: doc.data()['question'] ?? '',
        datetime: dateTime ?? '00/00/0000 00.00xx',
      );
    }).toList();
  }

  Stream<List<Cart>> get cartList {
    return customerCollection
        .doc(uid)
        .collection('cart')
        .snapshots()
        .map(_cartListFromSS);
  }

  //check if the cart is empty or not
  Future isCartEmpty() async {
    final cart = await customerCollection.doc(uid).collection('cart').get();
    return (cart.docs.length != 0) ? false : true;
  }

  //delete the whole cart
  void deleteCart() {
    Future<QuerySnapshot> cart =
        customerCollection.doc(uid).collection('cart').get();
    cart.then((value) {
      value.docs.forEach((element) {
        customerCollection.doc(uid).collection('cart').doc(element.id).delete();
      });
    });
  }

  //delete item from cart and reupdating the number of pax of the food
  Future<void> deleteFoodFromCart(int pax) async {
    int currFoodPax;
    await restaurantCollection
        .doc(ruid)
        .collection('food')
        .doc(fid)
        .get()
        .then((value) {
      currFoodPax = value.data()['pax'];
    });

    int newPax = currFoodPax + pax;

    await customerCollection.doc(uid).collection('cart').doc(cid).delete();
    restaurantCollection
        .doc(ruid)
        .collection('food')
        .doc(fid)
        .update({'pax': newPax});
  }

  Future<void> submitFeedback(String feedback, int rating) async {
    customerCollection
        .doc(uid)
        .collection('acceptHistory')
        .doc(fid)
        .update({'feedback': feedback, 'rating': rating});
    restaurantCollection
        .doc(ruid)
        .collection('acceptHistory')
        .doc(fid)
        .update({'feedback': feedback, 'rating': rating});
  }

  //checking if the food is already in the cart or not
  Future<bool> isFoodIsAlreadyInCart(String id) async {
    String cartFood;
    bool alreadyIn, notIn = false;

    await customerCollection.doc(uid).collection('cart').get().then((value) {
      value.docs.forEach((element) {
        cartFood = element.data()['fid'];
        cartFood == id ? alreadyIn = true : notIn = true;
      });
    });
    if (alreadyIn == true) {
      return true;
    } else if (notIn == true) {
      return false;
    } else {
      return false;
    }
  }

  //calculating the total price in the cart
  Future calcCartTotalPrice() async {
    QuerySnapshot querySnapshot =
        await customerCollection.doc(uid).collection('cart').get();
    double finalPrice = 0;

    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];

      var snapshot =
          await customerCollection.doc(uid).collection('cart').doc(a.id).get();

      int pax = snapshot.data()['paxWanted'];
      double price = snapshot.data()['salePrice'];

      finalPrice = finalPrice + (pax * price);
    }
    return finalPrice;
  }

  //? Order
  //creating an order subcollection for restaurant and customer
  // with a fooditem subsubcollection duplicated from cart
  Future<void> createOrder(String cuid, String ruid, String message,
      String pickUpTime, double totalPrice) async {
    DateTime datetime = DateTime.now();
    String date =
        '${datetime.day.toString().padLeft(2, '0')}/${datetime.month.toString().padLeft(2, '0')}/${datetime.year.toString().padLeft(2, '0')}';

    // var newOrderDoc = customerCollection.doc(uid).collection('order').doc();
    // var newOrderDocID = newOrderDoc.id;

    //creating order customer
    await customerCollection.doc(uid).collection('order').doc(fid).set({
      'oid': fid,
      'cuid': cuid,
      'ruid': ruid,
      'message': message,
      'date': date,
      'pickUpTime': datetime.add(Duration(minutes: int.parse(pickUpTime))),
      'orderTime': datetime,
      'totalPrice': totalPrice,
      'pending': true,
      'accepted': false,
      'completed': false,
      'ready': false,
    });

    //to duplicate cart fooditem into order customer fooditem
    customerCollection.doc(uid).collection('cart').get().then((value) {
      value.docs.forEach((element) {
        customerCollection
            .doc(uid)
            .collection('order')
            .doc(fid)
            .collection('fooditem')
            .doc()
            .set(element.data());
      });
    });

    //creating order restaurant
    await restaurantCollection.doc(ruid).collection('order').doc(fid).set({
      'oid': fid,
      'cuid': cuid,
      'ruid': ruid,
      'message': message,
      'date': date,
      'pickUpTime': datetime.add(Duration(minutes: int.parse(pickUpTime))),
      'orderTime': datetime,
      'totalPrice': totalPrice,
      'pending': true,
      'accepted': false,
      'completed': false,
      'ready': false,
    });

    //to duplicate cart fooditem into order restaurant fooditem
    customerCollection.doc(uid).collection('cart').get().then((value) {
      value.docs.forEach((element) {
        restaurantCollection
            .doc(ruid)
            .collection('order')
            .doc(fid)
            .collection('fooditem')
            .doc()
            .set(element.data());
      });
    });

    deleteCart();
  }

  //returning the list of orders from a customer
  List<Order> _orderListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Timestamp pickUpTS = doc.data()['pickUpTime'] as Timestamp;
      DateTime pickUpDT = pickUpTS.toDate();

      Timestamp orderTS = doc.data()['orderTime'] as Timestamp;
      DateTime orderDT = orderTS.toDate();

      String date =
          '${pickUpDT.day.toString().padLeft(2, '0')}/${pickUpDT.month.toString().padLeft(2, '0')}/${pickUpDT.year.toString().padLeft(2, '0')}';
      String orderT = DateFormat('jm').format(orderDT);
      String pickUpT = DateFormat('jm').format(pickUpDT);
      return Order(
        oid: doc.data()['oid'] ?? '',
        cuid: doc.data()['cuid'] ?? '',
        ruid: doc.data()['ruid'] ?? '',
        message: doc.data()['message'] ?? '',
        date: date ?? '00/00/0000',
        pickUpTime: pickUpT ?? '00:00:00',
        orderTime: orderT ?? '00:00:00',
        totalPrice: doc.data()['totalPrice'] ?? 0,
        ready: doc.data()['ready'] ?? false,
        completed: doc.data()['completed'] ?? false,
        accepted: doc.data()['accepted'] ?? false,
        pending: doc.data()['pending'] ?? true,
      );
    }).toList();
  }

  Stream<List<Order>> get order {
    return customerCollection
        .doc(uid)
        .collection('order')
        // .orderBy('date', descending: true)
        .orderBy('pickUpTime', descending: true)
        .snapshots()
        .map(_orderListFromSS);
  }

  //returning a single order
  Order _orderDataFromSS(DocumentSnapshot snapshot) {
    Timestamp pickUpTS = snapshot.data()['pickUpTime'] as Timestamp;
    DateTime pickUpDT = pickUpTS.toDate();

    Timestamp orderTS = snapshot.data()['orderTime'] as Timestamp;
    DateTime orderDT = orderTS.toDate();

    String date =
        '${pickUpDT.day.toString().padLeft(2, '0')}/${pickUpDT.month.toString().padLeft(2, '0')}/${pickUpDT.year.toString().padLeft(2, '0')}';
    String orderT = DateFormat('jm').format(orderDT);
    String pickUpT = DateFormat('jm').format(pickUpDT);

    return Order(
      oid: snapshot.data()['oid'] ?? '',
      cuid: snapshot.data()['cuid'] ?? '',
      ruid: snapshot.data()['ruid'] ?? '',
      message: snapshot.data()['message'] ?? '',
      date: date ?? '00/00/0000',
      pickUpTime: pickUpT ?? '00:00:00',
      orderTime: orderT ?? '00:00:00',
      totalPrice: snapshot.data()['totalPrice'] ?? 0,
      ready: snapshot.data()['ready'] ?? false,
      completed: snapshot.data()['completed'] ?? false,
      accepted: snapshot.data()['accepted'] ?? false,
      pending: snapshot.data()['pending'] ?? true,
    );
  }

  Stream<Order> get orderData {
    return customerCollection
        .doc(uid)
        .collection('order')
        .doc(fid)
        .snapshots()
        .map(_orderDataFromSS);
  }

  //returning the list of fooditems in the order
  List<FoodItem> _foodItemListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FoodItem(
        cid: doc.data()['cid'] ?? '',
        cuid: doc.data()['cuid'] ?? '',
        fid: doc.data()['fid'] ?? '',
        ruid: doc.data()['ruid'] ?? '',
        name: doc.data()['name'] ?? '',
        salePrice: doc.data()['salePrice'] ?? 0.0,
        paxWanted: doc.data()['paxWanted'] ?? 0,
        imageURL: doc.data()['imageURL'] ?? '',
      );
    }).toList();
  }

  Stream<List<FoodItem>> get foodItem {
    return customerCollection
        .doc(uid)
        .collection('order')
        .doc(fid)
        .collection('fooditem')
        .snapshots()
        .map(_foodItemListFromSS);
  }

  //update the number of pax of food after customer places an order
  void updatePax(int pax) async {
    Future<QuerySnapshot> foodToUpdatePax =
        restaurantCollection.doc(uid).collection('food').get();
    foodToUpdatePax.then((value) {
      value.docs.forEach((element) {
        restaurantCollection.doc(uid).collection('food').doc(fid).update({
          'pax': pax,
        });
      });
    });
  }

  void deleteOrder() {
    var toDelete = customerCollection.doc(uid).collection('order').doc(fid);

    //delete the fooditems in order

    Future<QuerySnapshot> foodItemInCustAccept =
        toDelete.collection('fooditem').get();
    foodItemInCustAccept.then((value) {
      value.docs.forEach((element) {
        toDelete.collection('fooditem').doc(element.id).delete();
      });
    });

    //delete order
    toDelete.delete();
  }

  Future createHistoryFromAccept() async {
    var orderCust = customerCollection.doc(uid).collection('order').doc(fid);
    var historyCustSub =
        customerCollection.doc(uid).collection('acceptHistory').doc(fid);

    // duplicating order into history
    orderCust.get().then((value) {
      historyCustSub.set(value.data());
      historyCustSub.update({
        'ahid': fid,
        'ready': true,
        'completed': false,
        'aid': FieldValue.delete(),
        'oid': FieldValue.delete(),
        'pending': false,
      });
    });

    //duplicating the fooditem from order into history
    orderCust.collection('fooditem').get().then((value) {
      value.docs.forEach((element) {
        customerCollection
            .doc(uid)
            .collection('acceptHistory')
            .doc(fid)
            .collection('fooditem')
            .doc()
            .set(element.data());
      });
    });

    deleteOrder();
  }

  //returning the list of history orders in a restaurant
  List<AcceptHistory> _acceptHistoryListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Timestamp pickUpTS = doc.data()['pickUpTime'] as Timestamp;
      DateTime pickUpDT = pickUpTS.toDate();

      Timestamp orderTS = doc.data()['orderTime'] as Timestamp;
      DateTime orderDT = orderTS.toDate();

      String datee =
          '${pickUpDT.day.toString().padLeft(2, '0')}/${pickUpDT.month.toString().padLeft(2, '0')}/${pickUpDT.year.toString().padLeft(2, '0')}';
      String orderT = DateFormat('jm').format(orderDT);
      String pickUpT = DateFormat('jm').format(pickUpDT);
      return AcceptHistory(
        ahid: doc.data()['ahid'] ?? '',
        cuid: doc.data()['cuid'] ?? '',
        ruid: doc.data()['ruid'] ?? '',
        message: doc.data()['message'] ?? '',
        date: doc.data()['date'] ?? '00/00/0000',
        pickUpTime: pickUpT ?? '00:00:00',
        orderTime: orderT ?? '00:00:00',
        totalPrice: doc.data()['totalPrice'] ?? 0,
        ready: doc.data()['ready'] ?? false,
        completed: doc.data()['completed'] ?? false,
        accepted: doc.data()['accepted'] ?? false,
        reason: doc.data()['reason'] ?? '',
        pending: doc.data()['pending'] ?? true,
      );
    }).toList();
  }

  Stream<List<AcceptHistory>> get acceptHistory {
    return customerCollection
        .doc(uid)
        .collection('acceptHistory')
        // .orderBy('date', descending: true)
        // .orderBy('pickUpTime', descending: true)
        .snapshots()
        .map(_acceptHistoryListFromSS);
  }

  //returning a single history order
  AcceptHistory _acceptHistoryDataFromSS(DocumentSnapshot snapshot) {
    Timestamp pickUpTS = snapshot.data()['pickUpTime'] as Timestamp;
    DateTime pickUpDT = pickUpTS.toDate();

    Timestamp orderTS = snapshot.data()['orderTime'] as Timestamp;
    DateTime orderDT = orderTS.toDate();

    String datee =
        '${pickUpDT.day.toString().padLeft(2, '0')}/${pickUpDT.month.toString().padLeft(2, '0')}/${pickUpDT.year.toString().padLeft(2, '0')}';
    String orderT = DateFormat('jm').format(orderDT);
    String pickUpT = DateFormat('jm').format(pickUpDT);
    return AcceptHistory(
      ahid: snapshot.data()['ahid'] ?? '',
      cuid: snapshot.data()['cuid'] ?? '',
      ruid: snapshot.data()['ruid'] ?? '',
      message: snapshot.data()['message'] ?? '',
      date: snapshot.data()['date'] ?? '00/00/0000',
      pickUpTime: pickUpT ?? '00:00:00',
      orderTime: orderT ?? '00:00:00',
      totalPrice: snapshot.data()['totalPrice'] ?? 0,
      ready: snapshot.data()['ready'] ?? false,
      completed: snapshot.data()['completed'] ?? false,
      accepted: snapshot.data()['accepted'] ?? false,
      reason: snapshot.data()['reason'] ?? '',
      pending: snapshot.data()['pending'] ?? true,
    );
  }

  Stream<AcceptHistory> get acceptHistoryData {
    return customerCollection
        .doc(uid)
        .collection('acceptHistory')
        .doc(fid)
        .snapshots()
        .map(_acceptHistoryDataFromSS);
  }

  //returning the list of fooditems in the history order
  List<FoodItem> _acceptHistoryFoodItemListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FoodItem(
        cid: doc.data()['cid'] ?? '',
        cuid: doc.data()['cuid'] ?? '',
        fid: doc.data()['fid'] ?? '',
        ruid: doc.data()['ruid'] ?? '',
        name: doc.data()['name'] ?? '',
        salePrice: doc.data()['salePrice'] ?? 0.0,
        paxWanted: doc.data()['paxWanted'] ?? 0,
        imageURL: doc.data()['imageURL'] ?? '',
      );
    }).toList();
  }

  Stream<List<FoodItem>> get acceptHistoryFoodItem {
    return customerCollection
        .doc(uid)
        .collection('acceptHistory')
        .doc(fid)
        .collection('fooditem')
        .snapshots()
        .map(_acceptHistoryFoodItemListFromSS);
  }

  //returning the list of history orders in a restaurant
  List<DeclineHistory> _declineHistoryListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      Timestamp pickUpTS = doc.data()['pickUpTime'] as Timestamp;
      DateTime pickUpDT = pickUpTS.toDate();

      Timestamp orderTS = doc.data()['orderTime'] as Timestamp;
      DateTime orderDT = orderTS.toDate();

      String datee =
          '${pickUpDT.day.toString().padLeft(2, '0')}/${pickUpDT.month.toString().padLeft(2, '0')}/${pickUpDT.year.toString().padLeft(2, '0')}';
      String orderT = DateFormat('jm').format(orderDT);
      String pickUpT = DateFormat('jm').format(pickUpDT);
      return DeclineHistory(
        dhid: doc.data()['dhid'] ?? '',
        cuid: doc.data()['cuid'] ?? '',
        ruid: doc.data()['ruid'] ?? '',
        message: doc.data()['message'] ?? '',
        date: doc.data()['date'] ?? '00/00/0000',
        pickUpTime: pickUpT ?? '00:00:00',
        orderTime: orderT ?? '00:00:00',
        totalPrice: doc.data()['totalPrice'] ?? 0,
        ready: doc.data()['ready'] ?? false,
        completed: doc.data()['completed'] ?? false,
        accepted: doc.data()['accepted'] ?? false,
        reason: doc.data()['reason'] ?? '',
        pending: doc.data()['pending'] ?? true,
      );
    }).toList();
  }

  Stream<List<DeclineHistory>> get declineHistory {
    return customerCollection
        .doc(uid)
        .collection('declineHistory')
        .orderBy('date', descending: true)
        // .orderBy('pickUpTime', descending: true)
        .snapshots()
        .map(_declineHistoryListFromSS);
  }

  //returning a single history order
  DeclineHistory _declineHistoryDataFromSS(DocumentSnapshot snapshot) {
    Timestamp pickUpTS = snapshot.data()['pickUpTime'] as Timestamp;
    DateTime pickUpDT = pickUpTS.toDate();

    Timestamp orderTS = snapshot.data()['orderTime'] as Timestamp;
    DateTime orderDT = orderTS.toDate();

    String datee =
        '${pickUpDT.day.toString().padLeft(2, '0')}/${pickUpDT.month.toString().padLeft(2, '0')}/${pickUpDT.year.toString().padLeft(2, '0')}';
    String orderT = DateFormat('jm').format(orderDT);
    String pickUpT = DateFormat('jm').format(pickUpDT);
    return DeclineHistory(
      dhid: snapshot.data()['dhid'] ?? '',
      cuid: snapshot.data()['cuid'] ?? '',
      ruid: snapshot.data()['ruid'] ?? '',
      message: snapshot.data()['message'] ?? '',
      date: snapshot.data()['date'] ?? '00/00/0000',
      pickUpTime: pickUpT ?? '00:00:00',
      orderTime: orderT ?? '00:00:00',
      totalPrice: snapshot.data()['totalPrice'] ?? 0,
      ready: snapshot.data()['ready'] ?? false,
      completed: snapshot.data()['completed'] ?? false,
      accepted: snapshot.data()['accepted'] ?? false,
      reason: snapshot.data()['reason'] ?? '',
      pending: snapshot.data()['pending'] ?? true,
    );
  }

  Stream<DeclineHistory> get declineHistoryData {
    return customerCollection
        .doc(uid)
        .collection('declineHistory')
        .doc(fid)
        .snapshots()
        .map(_declineHistoryDataFromSS);
  }

  //returning the list of fooditems in the history order
  List<FoodItem> _declineHistoryFoodItemListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FoodItem(
        cid: doc.data()['cid'] ?? '',
        cuid: doc.data()['cuid'] ?? '',
        fid: doc.data()['fid'] ?? '',
        ruid: doc.data()['ruid'] ?? '',
        name: doc.data()['name'] ?? '',
        salePrice: doc.data()['salePrice'] ?? 0.0,
        paxWanted: doc.data()['paxWanted'] ?? 0,
        imageURL: doc.data()['imageURL'] ?? '',
      );
    }).toList();
  }

  Stream<List<FoodItem>> get declineHistoryFoodItem {
    return customerCollection
        .doc(uid)
        .collection('declineHistory')
        .doc(fid)
        .collection('fooditem')
        .snapshots()
        .map(_declineHistoryFoodItemListFromSS);
  }
}
