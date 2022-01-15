import 'dart:async';

import 'package:flutter/material.dart';
//import 'package:vcet/frontend/appbar.dart';
//import 'package:vcet/frontend/background.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vcet/chat/helper/helper_functions.dart';
import 'package:vcet/chat/pages/home_page.dart';
import 'package:vcet/frontend/detail.dart';
import 'package:vcet/frontend/drawers.dart';
import 'package:vcet/frontend/login.dart';
//import 'package:vcet/frontend/department/ece.dart';
//import 'package:vcet/frontend/firstpage.dart';
//import 'package:vcet/frontend/login.dart';

class splashpage extends StatefulWidget {
  const splashpage({Key? key}) : super(key: key);

  @override
  _splashpageState createState() => _splashpageState();
}

class _splashpageState extends State<splashpage> {
  String finalId = "";
  String finalName = "";

  @override
  void initState() {
    super.initState();
    getValidationData().whenComplete(() async {
      Timer(Duration(seconds: 2), () {
        if (finalId == "" && finalName == "") {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => loginpage()));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => drawers()));
        }
      });
    });
  }

  Future getValidationData() async {
    String obtainedId = await HelperFunctions.getUserIdSharedPreference();
    String obtainedName = await HelperFunctions.getUserNameSharedPreferences();
    setState(() {
      finalId = obtainedId;
      finalName = obtainedName;
    });
    print(finalId);
  }

  @override
  Widget build(BuildContext context) {
    
    final double profileheight = 144;
    return Container(
      color: Colors.white,
      child:  CircleAvatar(
      backgroundColor: Colors.white,
      child: CircleAvatar(
        child: Container(
      decoration: BoxDecoration(),
        ),
        radius: profileheight/2,
        backgroundColor: Colors.white,
        backgroundImage: AssetImage('images/logo1.webp')
      ),
    ),
    );
  }
}
