import 'dart:async';

import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vcet/chat/pages/home_page.dart';
import 'package:vcet/frontend/background.dart';
import 'package:vcet/frontend/drawers.dart';
import 'package:vcet/frontend/firstpage.dart';
import 'package:vcet/frontend/login.dart';

class splashpage extends StatefulWidget {
  const splashpage({Key? key}) : super(key: key);

  @override
  _splashpageState createState() => _splashpageState();
}

class _splashpageState extends State<splashpage> {
  String finalId = " ";

  @override
  void initState() {
    super.initState();
    getValidationData().whenComplete(() async {
      Timer(Duration(seconds: 2), () {
        if (finalId == " ") {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => loginpage()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) =>  drawers()));
        }
      });
    });
  }

  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedId = sharedPreferences.getString('RollNo');
    setState(() {
      finalId = obtainedId!;
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const Center(
          child: Image(
        image: AssetImage('images/logo1.webp'),
      )),
    );
  }
}
