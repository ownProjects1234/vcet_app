import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vcet/backend/uploadfie.dart';
import 'package:vcet/frontend/splashscreen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: UploadPage(),
  ));
}
