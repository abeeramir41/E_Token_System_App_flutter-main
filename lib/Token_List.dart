
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class TokenList extends StatefulWidget {
  @override
  _TokenListState createState() => _TokenListState();
}

class _TokenListState extends State<TokenList> {
  var selectedOrganization;
  var selectedDepartment;



  // function to get token of selected organization
getTokens(var orgs, var dep)async {
  // current time to get only today's token
  DateTime dates = DateTime.now();
  print(orgs);
//  firebase query to retrive token
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("Organizations").doc(orgs).collection("department").doc(selectedDepartment).collection("tokens").orderBy("time").where("time",
      isGreaterThanOrEqualTo: DateTime(dates.year, dates.month, dates.day)).get();
 return querySnapshot.docs;
}

  @override
  Widget build(BuildContext context) {
   // String dropdownValue = 'Select';
    int time = 0;
    Future data = getTokens(selectedOrganization, selectedDepartment);
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(

        children: [
          // show organizations from firebase to dropdown
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
                      // final snackBar = SnackBar(
                      //   content: Text(
                      //     'Selected Organization value is a $orgs',
                      //     style: TextStyle(color: Colors.black),
                      //   ),
                      // );
                      // Scaffold.of(context).showSnackBar(snackBar);
                      setState(() {
                        // assign selected organizations
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
          SizedBox(height: 10.0,),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("Organizations").doc(selectedOrganization).collection("department").snapshots(),
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
                  return DropdownButton(
                    style: TextStyle(color: Colors.black87),
                    underline: Container(
                      height: 2,

                      color: Colors.green,
                    ),
                    icon: Icon(Icons.arrow_downward),
                    items: department,
                    onChanged: (orgs) async {
                      // final snackBar = SnackBar(
                      //   content: Text(
                      //     'Selected Organization value is a $orgs',
                      //     style: TextStyle(color: Colors.black),
                      //   ),
                      // );
                      // Scaffold.of(context).showSnackBar(snackBar);
                      var num =await FirebaseFirestore.instance.collection("Organization").doc(selectedOrganization).collection("department").doc(orgs).collection("tokenNum").doc().get();
                      //tokenNum = num.data()["tokenNum"];
                      //print(tokenNum);
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
                 print(snapshot.data.length);
                 return snapshot.data.length == 0 || snapshot.data.length == null ? Container(child: Text("No Tokens"),) :
                // show all tokens of selected organization
                 ListView.builder(
                     physics: NeverScrollableScrollPhysics(),
                     shrinkWrap: true,
                     itemCount: snapshot.data.length,
                     itemBuilder: (context, index){
                       // estimated time
                     time = time + 3;
                       return Container(
                           height: MediaQuery.of(context).size.height *0.1,

                           child:
                           Tokens(name: snapshot.data[index].data()["name"], tokenNum: snapshot.data[index].data()["tokenNum"].toString(),time: time,));
                     }
                 );
             }

         ),
        ],
      ),
    );
  }

}


// token UI
class Tokens extends StatefulWidget {
  String name;
  String tokenNum;
  int time;
  Tokens({this.name, this.tokenNum, this.time});
  @override
  _TokensState createState() => _TokensState();
}

class _TokensState extends State<Tokens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: ListTile(
          leading: Icon(
            Icons.account_circle,
            size: 40,
            color: Colors.green,
          ),
          title: Text(widget.name),
          subtitle: Text(widget.tokenNum),
          trailing: Text("Expected Time ${widget.time} mins", style: TextStyle(color: Colors.green),),
        ),
      ),
    );
  }
}
