
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class TokenList extends StatefulWidget {
  @override
  _TokenListState createState() => _TokenListState();
}

class _TokenListState extends State<TokenList> {
  var selectedOrganization;
getTokens(var orgs)async {
  print(orgs);
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("Organizations").doc(orgs).collection("tokens").get();
 return querySnapshot.docs;
}

  @override
  Widget build(BuildContext context) {
   // String dropdownValue = 'Select';

    Future data = getTokens(selectedOrganization);
    return SingleChildScrollView(
      child: Column(
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
                      print(selectedOrganization);
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
         SizedBox(height: 10,),
         FutureBuilder(
             future: data,
             builder: (context, snapshot){
               if (snapshot.connectionState == ConnectionState.waiting) {
                 return Center(
                   child: CircularProgressIndicator(),
                 );
               } else
                 return snapshot.data.length == 0 || snapshot.data.length == null ? Container(child: Text("No Tokens"),) :
                 ListView.builder(
                     shrinkWrap: true,
                     itemCount: snapshot.data.length,
                     itemBuilder: (context, index){
                       return Container(
                           height: MediaQuery.of(context).size.height *0.3,
                           child: Tokens(name: snapshot.data[index].data()["name"], tokenNum: snapshot.data[index].data()["tokenNum"].toString(),));
                     }
                 );
             }

         ),
        ],
      ),
    );
  }

}

class Tokens extends StatefulWidget {
  String name;
  String tokenNum;
  Tokens({this.name, this.tokenNum});
  @override
  _TokensState createState() => _TokensState();
}

class _TokensState extends State<Tokens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration: BoxDecoration(
          border: Border.all()
        ),
        child: ListTile(
          leading: Icon(
            Icons.account_circle,
            size: 40,
            color: Colors.green,
          ),
          title: Text(widget.name),
          subtitle: Text(widget.tokenNum),
          trailing: Text("Expected Time 10 mins", style: TextStyle(color: Colors.green),),
        ),
      ),
    );
  }
}
