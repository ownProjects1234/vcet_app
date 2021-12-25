import 'package:flutter/material.dart';

class librarys extends StatefulWidget {
  const librarys({Key? key}) : super(key: key);

  @override
  _librarysState createState() => _librarysState();
}

class _librarysState extends State<librarys> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Library"),
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
