import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elok_lagi/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:elok_lagi/models/users.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // create user obj based on firebase user
  Users _userFromFirebaseUser(User user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  // GET UID
  Future<String> getCurrentUID() async {
    return (_auth.currentUser).uid ;
  }

  // auth change user stream
  Stream<Users> get user {
    return _auth
        .authStateChanges()
        //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      //create a new doc for the customer with the uid
      await DatabaseService(uid: user.uid).updateCustomerData(
          'username', 'email', 'password', 'location', 'phoneNum');
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // void getCustomerInfo() async {
  //   final custInfo = await _firestore.collection('customer').get(user.uid);
  //   custInfo.docs
  // }
}
