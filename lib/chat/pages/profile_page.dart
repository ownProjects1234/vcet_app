import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String userName;
  final String userId;
  
  const ProfilePage({Key? key, required this.userId, required this.userName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle(color: Colors.white, fontSize: 27.0, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.black87,
        elevation: 0.0,
      ),

      body: Container(),
    );
  }
}
