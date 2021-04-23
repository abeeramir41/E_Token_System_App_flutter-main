import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'profile_Page.dart';

// ignore: camel_case_types
class Organization_Page extends StatefulWidget {
  @override
  _Organization_PageState createState() => _Organization_PageState();
}

class _Organization_PageState extends State<Organization_Page> {
  Future data;
  User user;
 var selectedDepartment;
  // get all organization token
  getTokens(var dep)async {
    DateTime dates = DateTime.now();
    // getting current user Id

     // getting documents query
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("Organizations").doc(user.uid).collection("department").doc(selectedDepartment).collection("tokens").orderBy("time").where("time",
        isGreaterThanOrEqualTo: DateTime(dates.year, dates.month, dates.day)).get();
    return querySnapshot.docs;
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xFF3BB44A),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Tokens List',
              textAlign: TextAlign.center,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => ProfilePage()));
                // do something
              },
            ),
          ],
        ),
        body:  Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("Organizations").doc(user.uid).collection("department").snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return CircularProgressIndicator();
                  else {
                    List<DropdownMenuItem> department = [];
                    for (int i = 0; i < snapshot.data.docs.length; i++) {
                      DocumentSnapshot snap = snapshot.data.docs[i];
                      department.add(
                        DropdownMenuItem(
                          child: Text(
                            snap['name'],
                            style: TextStyle(color: Colors.black),
                          ),
                          value: "${snap.id}",
                        ),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton(
                        style: TextStyle(color: Colors.black87),
                        underline: Container(
                          height: 2,

                          color: Colors.green,
                        ),
                        icon: Icon(Icons.arrow_downward),
                        items: department,
                        onChanged: (orgs) async {
                          final snackBar = SnackBar(
                            content: Text(
                              'Selected Organization value is a $orgs',
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                          setState(() {
                            selectedDepartment = orgs;
                          });
                        },
                        value: selectedDepartment,
                        isExpanded: true,
                        hint: new Text(
                          "Choose Department",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                  }

                }
            ),

            SizedBox(height: 10,),
            Expanded(
              child: Container(
                child: FutureBuilder(
                    future: getTokens(selectedDepartment),
                    builder: (context, snapshot){
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else
                        return snapshot.data.length == 0 || snapshot.data.length == null ? Container(child: Center(child: Text("No Tokens")),) :
                        // show all organization tokens
                        ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index){
                              return ListTile(
                                leading: Icon(
                                  Icons.account_circle,
                                  size: 40,
                                  color: Colors.green,
                                ),
                                title: Text(snapshot.data[index].data()["name"]),
                                subtitle: Text(snapshot.data[index].data()["tokenNum"].toString()),
                                trailing: InkWell(
                                  onTap: () async {
                                    showDialog(context: context,
                                        builder: (BuildContext context){
                                          return AlertDialog(
                                            title: Text("Are you sure?"),
                                            actions: [
                                              TextButton(onPressed: ()async {
                                                Navigator.pop(context);
                                                // delete selected token
                                                FirebaseFirestore.instance.collection("Organizations")
                                                    .doc(user.uid).collection("department").doc(selectedDepartment).collection("tokens").doc(snapshot.data[index].data()["tokenNum"].toString())
                                                    .delete()
                                                    .then((value) => print("User Deleted"))
                                                    .catchError((error) => print("Failed to delete user: $error"));


                                                setState(() {

                                                });
                                              }, child: Text("Yes")),

                                              TextButton(onPressed: (){
                                                Navigator.pop(context);
                                              }, child: Text("No")),
                                            ],
                                          );
                                        }

                                    );
                                  },
                                  child: Icon(Icons.delete),
                                ),
                              );
                            }
                        );
                    }

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

