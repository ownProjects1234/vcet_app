import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:vcet/frontend/chat.dart';
import 'package:vcet/frontend/firstpage.dart';
import 'package:vcet/frontend/notification.dart';
import 'package:vcet/frontend/quiz.dart';
import 'package:vcet/frontend/upload.dart';

class bottomnavigation extends StatefulWidget {
  const bottomnavigation({Key? key}) : super(key: key);

  @override
  _bottomnavigationState createState() => _bottomnavigationState();
}

class _bottomnavigationState extends State<bottomnavigation> {
  int index = 2;

  final screens = [
    const notification(),
    const upload(),
    const firstpage(),
    const quiz(),
    const chat()
  ];
  @override
  final items = <Widget>[
    const Icon(
      Icons.notification_important_rounded,
      size: 30,
    ),
    const Icon(Icons.upload_file_outlined, size: 30),
    const Icon(Icons.home_outlined, size: 30),
    const Icon(Icons.quiz_outlined, size: 30),
    const Icon(Icons.chat_sharp, size: 30),
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: screens[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: IconThemeData(color: Colors.black)),
        child: SafeArea(
          child: CurvedNavigationBar(
            backgroundColor: Colors.transparent,

            items: items,
            index: index,
            onTap: (index) => setState(() => this.index = index),
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 300),
            height: 60,
            buttonBackgroundColor: Colors.teal.shade100,

            //color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
