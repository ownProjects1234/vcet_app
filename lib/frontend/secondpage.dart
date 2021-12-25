import 'package:flutter/material.dart';

class secondpage extends StatefulWidget {
  const secondpage({Key? key}) : super(key: key);

  @override
  _secondpageState createState() => _secondpageState();
}

class _secondpageState extends State<secondpage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("successfully navigated")),
    );
  }
}
