import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => ZoomDrawer.of(context)!.toggle(),
            icon: Icon(Icons.menu)),
      ),
      body: Center(
        child: Text(
          "Page Building",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
