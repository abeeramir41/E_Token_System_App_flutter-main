import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class InputToken extends StatefulWidget {
  @override
  _InputTokenState createState() => _InputTokenState();
}

class _InputTokenState extends State<InputToken> {
  String dropdownValue = 'Select';
  var selectedOrganization;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  var _formkey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            // child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection("Organizations").snapshots(),
    builder: (context, snapshot) {
      if (!snapshot.hasData)
        return CircularProgressIndicator();
      else {
        List<DropdownMenuItem> organization = [];
        for (int i = 0; i < snapshot.data.docs.length; i++) {
          DocumentSnapshot snap = snapshot.data.docs[i];
          organization.add(
            DropdownMenuItem(
              child: Text(
                snap['name'],
                style: TextStyle(color: Colors.black),
              ),
              value: "${snap.id}",
            ),
          );
        }
        return DropdownButton(
          style: TextStyle(color: Colors.black87),
          underline: Container(
            height: 2,

            color: Colors.green,
          ),
          icon: Icon(Icons.arrow_downward),
            items: organization,
            onChanged: (orgs) {
          final snackBar = SnackBar(
            content: Text(
              'Selected Organization value is a $orgs',
              style: TextStyle(color: Colors.black),
            ),
          );
          Scaffold.of(context).showSnackBar(snackBar);
          setState(() {
            selectedOrganization = orgs;
          });
        },
              value: selectedOrganization,
                isExpanded: true,
               hint: new Text(
                "Choose Organization",
                style: TextStyle(color: Colors.black),
               ),
               );
      }

    }
    ),


              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: email,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter Email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: name,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              TextFormField(
                controller: phone,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter your Phone Number';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Contact Number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: double.infinity,
                // height: 35,
                child: RaisedButton(
                  color: Colors.green,
                  onPressed: () async {
                      if (_formkey.currentState.validate()){
                        int tokenNum = Random().nextInt(100000);
                        await FirebaseFirestore.instance.collection("Organizations").doc(selectedOrganization)
                        .collection("tokens").doc(tokenNum.toString()).set(
                          {
                            "name" : name.text,
                            "email" : email.text,
                            "phone" : phone.text,
                            "tokenNum" : tokenNum,
                            "time" : DateTime.now()
                          }
                        );
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text('Token Generated')));
                      
                    return null;
                    }
                  },
                  child: Text(
                    'GET TOKEN',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
