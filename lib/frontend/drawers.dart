import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:vcet/chat/pages/home_page.dart';
import 'package:vcet/frontend/busroute.dart';
import 'package:vcet/frontend/firstpage1.dart';

import 'package:vcet/frontend/library.dart';
import 'package:vcet/frontend/menupage.dart';
import 'package:vcet/frontend/profile.dart';
import 'package:vcet/frontend/quiz.dart';
import 'package:vcet/main.dart';

import '../backend/providers/get_user_info.dart';
import '../backend/update_profile_to_firestore.dart';

class drawers extends StatefulWidget {
  @override
  _drawersState createState() => _drawersState();
}

class _drawersState extends State<drawers> {
  MenuItems currentItem = Menuitem.home;

        @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (currentUser?.noticeCount != 0) {
      // alertBox('NOTICE', "You have a notice, visit notification page",
      //     'noticeCount', context);
      Notify("NOTICE", "You have a notice, visit notification page");
      userRef.doc((currentUser?.rollNo)!).update({"noticeCount": 0});
      firebasefirestore().getUserInfo(currentUser?.rollNo);
      print(currentUser?.noticeCount);
    } else if (currentUser?.queryCount != 0) {
      // alertBox(
      //     'QUERY',
      //     'You have a query from a student,please visit query page',
      //     "queryCount",
      //     context);
      Notify(
          "QUERY", 'You have a query from a student, please visit query page');
      userRef.doc((currentUser?.rollNo)!).update({"queryCount": 0});
      firebasefirestore().getUserInfo(currentUser?.rollNo);
      print("after notify $currentUser?.queryCount");
    } else {
      null;
    }
  }
 

  @override
  Widget build(BuildContext context) {


    return ZoomDrawer(
        style: DrawerStyle.Style1,
        borderRadius: 40,
        angle: -10,
        slideWidth: MediaQuery.of(context).size.width * 0.7,
        showShadow: true,
        backgroundColor: Colors.blue[400]!,
        menuScreen: Builder(
          builder: (context) => menupage(
              currentItem: currentItem,
              onSelectedItem: (item) {
                setState(() => currentItem = item);
                ZoomDrawer.of(context)!.close();
              }),
        ),
        mainScreen: getscreen());
  }

  Widget getscreen() {
    switch (currentItem) {
      case Menuitem.home:
        return const bottomnavigation();

      case Menuitem.profile:
        return const profile();
      case Menuitem.busroute:
        return const busroute();
      case Menuitem.library:
        return const librarys();
      case Menuitem.quiz:
        return const Quiz();
      // case MenuItem.websitelogin:
      //   return const websitelogin();

      case Menuitem.chat:
        return const HomePage();
      default:
        return const bottomnavigation();
    }
  }
}
