import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vcet/backend/uploadfie.dart';
import 'package:vcet/frontend/login.dart';
import 'package:vcet/frontend/splashscreen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    theme: ThemeData(
        primaryColor: const Color(0xFF2661FA),
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity),
    debugShowCheckedModeBanner: false,
    home: const loginpage(),
  ));
}
