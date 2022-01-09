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
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload"),
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
