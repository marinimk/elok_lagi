import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elok_lagi/models/customer.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference customerCollection =
      FirebaseFirestore.instance.collection('customer');

  Future updateCustomerData(String username, String email, String password,
      String location, String phoneNum) async {
    return await customerCollection.doc(uid).set({
      'username': username,
      'email': email,
      'password': password,
      'location': location,
      'phoneNum': phoneNum,
    });
  }

  //customer list from snapshot
  List<Customer> _customerListFromSS(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Customer(
        username: doc.data()['username'] ?? '',
        email: doc.data()['email'] ?? '',
        password: doc.data()['password'] ?? '',
        location: doc.data()['location'] ?? '',
        phoneNum: doc.data()['phoneNum'] ?? '',
      );
    }).toList();
  }

  Stream<List<Customer>> get customer {
    return customerCollection.snapshots().map(_customerListFromSS);
  }
}
