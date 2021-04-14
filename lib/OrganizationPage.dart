import 'package:flutter/material.dart';
import 'profile_Page.dart';

// ignore: camel_case_types
class Organization_Page extends StatefulWidget {
  @override
  _Organization_PageState createState() => _Organization_PageState();
}

class _Organization_PageState extends State<Organization_Page> {
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
        body: ListView(
          children: [
            ListTile(
              leading: Icon(
                Icons.account_circle,
                size: 40,
                color: Colors.green,
              ),
              title: Text('User Name'),
              subtitle: Text('Token Number: 0000'),
              trailing: Icon(Icons.delete),
            )
          ],
        ),
      ),
    );
  }
}

