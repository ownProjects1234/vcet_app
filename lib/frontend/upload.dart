import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class upload extends StatefulWidget {
  const upload({Key? key}) : super(key: key);

  @override
  _uploadState createState() => _uploadState();
}

class _uploadState extends State<upload> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: Text("Upload"),
          centerTitle: true,
          leading: IconButton(
              onPressed: () => ZoomDrawer.of(context)!.toggle(),
              icon: Icon(Icons.menu)),
        ),
        body:const  Center(
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
