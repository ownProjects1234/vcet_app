import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vcet/colorClass.dart';

class stafflogin extends StatefulWidget {
  const stafflogin({Key? key}) : super(key: key);

  @override
  _staffloginState createState() => _staffloginState();
}

class _staffloginState extends State<stafflogin> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "STAFF LOGIN",
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
                    "https://cdn.shopify.com/s/files/1/0941/2500/files/Teachers_Day_Quotes_Woodgeek_Store_8eb9f5da-1a09-4f49-a9c9-59146b03abac_large.jpg?v=1566299402"),
              ),
              ElevatedButton(
                onPressed: () async {
                  final url =
                      //'http://vcet.ac.in/vcetattendance/ParentsLogin.php';
                      'http://vcet.ac.in/vcetattendance/Login.php';
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
