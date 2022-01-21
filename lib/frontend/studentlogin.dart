import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vcet/colorClass.dart';

import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class websitelogin extends StatefulWidget {
  const websitelogin({Key? key}) : super(key: key);

  @override
  _websiteloginState createState() => _websiteloginState();
}

class _websiteloginState extends State<websitelogin> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "STUDENT LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 3),
            ),
            backgroundColor: myColors.secondaryColor,
            leading: IconButton(
                onPressed: () => ZoomDrawer.of(context)!.toggle(),
                icon: Icon(Icons.menu)),
          ),
          backgroundColor: myColors.primaryColor,
          body: Center(
              child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 8.0, top: 15, left: 10, right: 10),
                child: Image.network(
                    "https://images.moneycontrol.com/static-mcnews/2021/07/shutterstock_1716623650-770x433.jpg?impolicy=website&width=770&height=431"),
              ),
              ElevatedButton(
                onPressed: () async {
                  final url =
                      'http://vcet.ac.in/vcetattendance/ParentsLogin.php';
                  if (await canLaunch(url)) {
                    await launch(url,
                        forceWebView: true, enableJavaScript: true);
                  }
                },
                child: const Text(
                  "Click here",
                  style: TextStyle(
                      fontSize: 15, letterSpacing: 2, color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                    // primary: myColors.buttonColor,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
              )
            ],
          ))),
    );
  }

  Future<bool> _onWillPop() async {
    final shouldpop = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => exit(0),
            /*Navigator.of(context).pop(true)*/
            child: Text('Yes'),
          ),
        ],
      ),
    );

    return shouldpop ?? false;
  }
}
