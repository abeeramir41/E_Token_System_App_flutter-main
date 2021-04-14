import 'package:etoken_flutter_app/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        primaryColor: Color(0xFF3BB44A),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/images/Splashscreenet.png'),
        nextScreen: HomeScreen(),
      splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}
