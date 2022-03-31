import 'package:flutter/material.dart';

class rotaract extends StatefulWidget {
  const rotaract({Key? key}) : super(key: key);

  @override
  _rotaractState createState() => _rotaractState();
}

class _rotaractState extends State<rotaract> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('R O T A R A C T'),
        centerTitle: true,
      ),
    );
  }
}
