import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:vcet/chat/pages/home_page.dart';
import 'package:vcet/colorClass.dart';
import 'package:vcet/frontend/firstpage.dart';
import 'package:vcet/frontend/library.dart';
import 'package:vcet/frontend/notification.dart';
import 'package:vcet/frontend/profile.dart';
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
    const librarys(),
    firstpage(),
    const profile(),
    const HomePage()
  ];
  @override
  final items = <Widget>[
    const Icon(
      Icons.notification_important_rounded,
      size: 30,
    ),
    const Icon(Icons.library_books, size: 30),
    const Icon(Icons.home_outlined, size: 30),
    const Icon(Icons.person_outline_rounded, size: 30),
    const Icon(Icons.chat, size: 30),
  ];
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
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
              buttonBackgroundColor: myColors.thirdColor,

              //          color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    final shouldpop = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => exit(0),
            // Navigator.of(context).pop(true),
            child: Text('Yes'),
          ),
        ],
      ),
    );

    return shouldpop ?? false;
  }
}
