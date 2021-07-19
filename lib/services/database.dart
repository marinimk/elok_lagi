import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elok_lagi/models/customer.dart';
import 'package:elok_lagi/models/food.dart';
import 'package:elok_lagi/models/restaurant.dart';
import 'package:flutter/cupertino.dart';

class DatabaseService {
  final String uid;
  DatabaseService({@required this.uid});

  // collection reference
  final CollectionReference customerCollection =
      FirebaseFirestore.instance.collection('customer');
  final CollectionReference restaurantCollection =
      FirebaseFirestore.instance.collection('restaurant');

  Future updateCustomerData(
      String username, String location, String phoneNum) async {
    return await customerCollection.doc(uid).set({
      'username': username,
      // 'email': email,
      // 'password': password,
      'location': location,
      'phoneNum': phoneNum,
    });
  }

  //customer list from snapshot
  List<Customer> _customerListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Customer(
        username: doc.data()['username'] ?? '',
        // email: doc.data()['email'] ?? '',
        // password: doc.data()['password'] ?? '',
        location: doc.data()['location'] ?? '',
        phoneNum: doc.data()['phoneNum'] ?? '',
      );
    }).toList();
  }

  //customer data from snapshot
  CustomerData _customerDataFromSS(DocumentSnapshot snapshot) {
    return CustomerData(
      uid: uid,
      username: snapshot.data()['username'] ?? '',
      // email: snapshot.data()['email'] ?? '',
      // password: snapshot.data()['password'] ?? '',
      location: snapshot.data()['location'] ?? '',
      phoneNum: snapshot.data()['phoneNum'] ?? '',
    );
  }

  List<RestaurantData> _restaurantListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return RestaurantData(
        uid: doc.data()['uid'] ?? '',
        name: doc.data()['name'] ?? '',
        // email: doc.data()['email'] ?? '',
        // password: doc.data()['password'] ?? '',
        category: doc.data()['category'] ?? '',
        location: doc.data()['location'] ?? '',
        phoneNum: doc.data()['phoneNum'] ?? '',
        status: doc.data()['status'] ?? false,
      );
    }).toList();
  }

  List<Food> _foodListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Food(
        name: doc.data()['name'] ?? '',
        description: doc.data()['description'] ?? '',
        oriPrice: doc.data()['oriPrice'] ?? 0.0,
        salePrice: doc.data()['salePrice'] ?? 0.0,
        pax: doc.data()['pax'] ?? 0,
      );
    }).toList();
  }

  Stream<List<Customer>> get customer {
    return customerCollection.snapshots().map(_customerListFromSS);
  }

  Stream<CustomerData> get customerData {
    return customerCollection.doc(uid).snapshots().map(_customerDataFromSS);
  }

  Stream<List<RestaurantData>> get restaurant {
    return restaurantCollection.snapshots().map(_restaurantListFromSS);
  }

  Stream<List<Food>> get food {
    return restaurantCollection
        .doc(uid)
        .collection('food')
        .snapshots()
        .map(_foodListFromSS);
  }
}
