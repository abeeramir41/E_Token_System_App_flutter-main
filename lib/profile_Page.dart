import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ProfilePage extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User user;

  String name;

  String email;

  getUser()async {
    user = FirebaseAuth.instance.currentUser;
   DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection("Organizations").doc(user.uid).get();
   print(documentSnapshot.data()["name"]);
   setState(() {
     name = documentSnapshot.data()["name"];
     email = documentSnapshot.data()["email"];
   });
   return documentSnapshot;

  }

  @override
  void initState() {
    getUser();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   // getTokens();
    return  Scaffold(
        appBar: AppBar(
          title: Center(
            child: const Text('Profile'),
          ),
        ),
        body:  name == null && email == null ? Center(child: CircularProgressIndicator(),) : ListView(
          children: <Widget>[
            Container(
              height: 250,
              color: Colors.green,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                       CircleAvatar(
                        backgroundColor: Colors.white70,
                        minRadius: 60.0,
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                          NetworkImage('https://avatars0.githubusercontent.com/u/28812093?s=460&u=06471c90e03cfd8ce2855d217d157c93060da490&v=4'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    name == null ?'Company Name' : name,
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    email == null ? 'Company@email.com' : email,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
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
