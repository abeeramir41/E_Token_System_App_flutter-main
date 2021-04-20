import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging();



// sign up code
  Future<User> createPerson(String name, String email, String password,String Phone) async {
    // sign up user with email and password
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    // adding data to organization table on successful sign up
    await _firestore
        .collection("Organizations")
        .doc(user.user.uid)
        .set({'name': name, 'email': email,'phone':Phone,'uid': user.user.uid, });
// adding data to tokenNum table on successful sign up
    // we will give default tokenNum
    await _firestore
        .collection("tokenNum")
        .doc(user.user.uid)
        .set({'tokenNum': 1000, });

    return user.user;
  }


}
