import 'package:flutter/material.dart';
import 'Home_Form.dart';
import 'Token_List.dart';
import 'login_screen.dart';

pressed btnPressed;
enum pressed {
  Input,
  List,
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('HOME'),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0x295d5d5d),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text('Powered by Leads',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 11,
              fontWeight: FontWeight.w100,
            ),),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
          child: Column(
            children: [
              Container(
                // height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: Colors.teal,
                ),
                child: Image.asset(
                  'assets/images/Homeimage.png',
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                        onPressed: () {
                          setState(() {
                              btnPressed = pressed.Input;
                          });
                        },
                        color: Colors.green,
                        // hoverColor: Colors.white,
                        splashColor: Colors.white,
                        child: Text('Token'),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: RaisedButton(
                        onPressed: (){
                          setState(() {
                            btnPressed = pressed.List;
                          });
                        },
                        color: Color(0xFF3BB44A),
                        child: Text('List'),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  // color: Colors.green,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.green),
                    // color: Colors.green,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomContainer(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'if you are a company login here',
                  style: TextStyle(fontSize: 12, color: Color(0xCF000000)),
                ),
              ),
              Container(
                width: double.infinity,
                height: 35,
                child: RaisedButton(
                  color: Colors.green,
                  onPressed:(){
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Login_form()) );
                    });
                },
                  child: Text('Login', style: TextStyle(
                    color: Colors.white,
                  ),),
                  splashColor: Colors.white,
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
// ignore: non_constant_identifier_names
Widget CustomContainer(){
  if(btnPressed == pressed.List){
    return TokenList();
  }else
    return InputToken();
}