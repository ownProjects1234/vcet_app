// ignore_for_file: camel_case_types

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vcet/chat/helper/helper_functions.dart';
import 'package:vcet/colorClass.dart';

import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class websitelogin extends StatefulWidget {
  const websitelogin({Key? key}) : super(key: key);

  @override
  _websiteloginState createState() => _websiteloginState();
}

class _websiteloginState extends State<websitelogin> {
  String? uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfo();
  }

  getInfo() async {
    HelperFunctions.getUserIdSharedPreference().then((value) {
      setState(() {
        uid = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        var datas = snapshot.data;

        if (datas['staff'] == 'false') {
          return WillPopScope(
            onWillPop: () => _onWillPop(),
            child: Scaffold(
                appBar: AppBar(
                  title: const Text(
                    "STUDENT LOGIN",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, letterSpacing: 3),
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
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.black),
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
        } else {
          return WillPopScope(
            onWillPop: () => _onWillPop(),
            child: Scaffold(
                appBar: AppBar(
                  title: const Text(
                    "STAFF LOGIN",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, letterSpacing: 3),
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
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.black),
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
      },
    );
  }

  Future<bool> _onWillPop() async {
    final shouldpop = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content:const Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child:const Text('No'),
          ),
          TextButton(
            onPressed: () => exit(0),
            /*Navigator.of(context).pop(true)*/
            child:const Text('Yes'),
          ),
        ],
      ),
    );

    return shouldpop ?? false;
  }
}
