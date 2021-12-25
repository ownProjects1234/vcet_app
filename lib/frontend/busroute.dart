import 'package:flutter/material.dart';

class busroute extends StatefulWidget {
  const busroute({Key? key}) : super(key: key);

  @override
  _busrouteState createState() => _busrouteState();
}

class _busrouteState extends State<busroute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Busroute"),
        centerTitle: true,
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
