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


  Future<User> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    return user.user;
  }

  signOut() async {
    return await _auth.signOut();
  }

  Future<User> createPerson(String name, String email, String password,String Phone) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
//    String fcmToken= await _fcm.getToken();
    await _firestore
        .collection("Organizations")
        .doc(user.user.uid)
        .set({'name': name, 'email': email,'phone':Phone,'uid': user.user.uid,'tokenNum': 1000,'status':false, });

    await _firestore
        .collection("tokenNum")
        .doc(user.user.uid)
        .set({'tokenNum': 1000, });

    return user.user;
  }


}
