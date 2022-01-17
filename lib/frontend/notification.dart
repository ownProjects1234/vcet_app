import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:vcet/colorClass.dart';

class notification extends StatefulWidget {
  const notification({Key? key}) : super(key: key);

  @override
  _notificationState createState() => _notificationState();
}

class _notificationState extends State<notification> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        backgroundColor: myColors.primaryColor,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: myColors.secondaryColor,
          title: Text("N O T I F I C A T I O N", style: TextStyle(fontWeight: FontWeight.bold),),
          centerTitle: true,
          leading: IconButton(
              onPressed: () => ZoomDrawer.of(context)!.toggle(),
              icon: Icon(Icons.menu)),
        ),
        body: const Center(
          child: Text(
            "Page Building",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
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
