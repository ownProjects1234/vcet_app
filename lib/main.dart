import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vcet/frontend/detail.dart';
import 'package:vcet/frontend/firstpage.dart';
import 'package:vcet/frontend/login.dart';
import 'package:vcet/frontend/queryPage.dart';
import 'package:vcet/frontend/quiz.dart';
import 'package:vcet/frontend/splashscreen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const myapp());
}

class myapp extends StatelessWidget {
  const myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          '/screen1': (context) => firstpage(),
        },
        theme: ThemeData(
            primaryColor: const Color(0xFF2661FA),
            scaffoldBackgroundColor: Colors.white,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        debugShowCheckedModeBanner: false,
        home: const splashpage());
  }
}
