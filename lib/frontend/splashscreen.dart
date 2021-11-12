import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:vcet/frontend/background.dart';

class splashpage extends StatefulWidget {
  const splashpage({Key? key}) : super(key: key);

  @override
  _splashpageState createState() => _splashpageState();
}

class _splashpageState extends State<splashpage> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image.asset("images/vcet_logo.jpg"),
      nextScreen: background_page(
        child: Column(),
      ),
      splashIconSize: 230.0,
      splashTransition: SplashTransition.fadeTransition,
      duration: 1500,
    );
  }
}
