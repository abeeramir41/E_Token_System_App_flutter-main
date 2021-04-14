
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class TokenList extends StatefulWidget {
  @override
  _TokenListState createState() => _TokenListState();
}

class _TokenListState extends State<TokenList> {



  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'Select';

    return Container(
      child: Column(
        children: [

          DropdownButton<String>(
            isExpanded: true,
            value: dropdownValue,
            icon: Icon(Icons.arrow_downward),
            // iconSize: 24,
            // elevation: 16,
            style: TextStyle(color: Colors.black87),
            underline: Container(
              height: 2,
              color: Colors.green,
            ),
            onChanged: (String newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            items:
            <String>['Select', 'One', 'Two', 'Free', 'Four']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),

          ),
         
        ],
      ),
    );
  }

}

