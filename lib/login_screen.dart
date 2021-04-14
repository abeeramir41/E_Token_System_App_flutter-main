

import 'package:etoken_flutter_app/OrganizationPage.dart';
import 'package:etoken_flutter_app/packages/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'ReuseAble.dart';
import 'registerScreen.dart';
import 'OrganizationPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login_form extends StatefulWidget {
  @override
  _Login_formState createState() => _Login_formState();
}


class _Login_formState extends State<Login_form> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthService _authService = AuthService();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  String stateuss;
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Log in')),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Container(
                  // width:  double.infinity,
                  height: 100.0,
                  child: Image.asset('assets/images/Splashscreenet.png',),
                ),
              ),
              SizedBox(height: 30.0,),
              Form(

                child: Column(
                  children: <Widget>[
                    _textEmailInput(hint: "Email", icon: Icons.email),
                    _textPassInput(hint: "Password", icon: Icons.vpn_key),

                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: double.infinity,
                        height: 35.0,
                        child: RaisedButton(
                          onPressed: ()  async {
                            DocumentSnapshot document = await FirebaseFirestore.instance.collection('Organizations').document(emailController.text).get();


                            // if(document['status']== 'false'){
                            //   print(document['status']);
                            //   Fluttertoast.showToast(msg: "You Need Aproval from admin for login");
                            // }else{
                            _authService
                                .signIn(
                                emailController.text, passwordController.text)
                                .then((value) {
                              if(value!=null) {
                                Center(child: CircularProgressIndicator());
                                return Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Organization_Page()
                                    ));
                              }
                            });

                          },
                          color: Theme.of(context).primaryColor,
                          splashColor: Colors.white,
                          highlightElevation: 0.0,
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          child: Text(
                            "Sign In",
                            style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: double.infinity,
                        height: 35.0,
                        child: RaisedButton(
                          onPressed: ()   {
                            setState(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpForm()
                                  ));
                            });
                          },
                          color: Theme.of(context).primaryColor,
                          splashColor: Colors.white,
                          highlightElevation: 0.0,
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          child: Text(
                            "Register Now",
                            style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _textEmailInput({controller, hint, icon}) {
    return Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextFormField(
          controller: emailController,
          decoration: InputDecoration(

            hintText: hint, hintStyle: TextStyle(
            fontSize: 15,

          ),
            prefixIcon: Icon(icon, size: 18,),
          ),
        )
    );
  }

  Widget _textPassInput({controller, hint, icon}) {
    return Container(
        margin: EdgeInsets.only(top: 5),
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TextFormField(
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(

            hintText: hint, hintStyle: TextStyle(
            fontSize: 15,

          ),
            prefixIcon: Icon(icon, size: 18,),
          ),
        )
    );
  }

}
