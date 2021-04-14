import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class InputToken extends StatefulWidget {
  @override
  _InputTokenState createState() => _InputTokenState();
}

class _InputTokenState extends State<InputToken> {
  String dropdownValue = 'Select';
  var selectedCurrency;
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
        const Text("Loading.....");
      else {
        List<DropdownMenuItem> currencyItems = [];
        for (int i = 0; i < snapshot.data.documents.length; i++) {
          DocumentSnapshot snap = snapshot.data.documents[i];
          currencyItems.add(
            DropdownMenuItem(
              child: Text(
                snap['name'],
                style: TextStyle(color: Colors.black),
              ),
              value: "${snap.documentID}",
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
            items: currencyItems,
            onChanged: (currencyValue) {
          final snackBar = SnackBar(
            content: Text(
              'Selected Currency value is $currencyValue',
              style: TextStyle(color: Colors.black),
            ),
          );
          Scaffold.of(context).showSnackBar(snackBar);
          setState(() {
            selectedCurrency = currencyValue;
          });
        },
      value: selectedCurrency,
      isExpanded: false,
      hint: new Text(
      "Choose Currency Type",
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
                  onPressed: () {
                    setState(() {
                      if (_formkey.currentState.validate()){
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text('Token Generated')));
                      }
                    return null;
                    }
                    );
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
