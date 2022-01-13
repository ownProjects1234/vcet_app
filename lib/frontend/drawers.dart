import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:vcet/chat/pages/home_page.dart';
import 'package:vcet/frontend/busroute.dart';
import 'package:vcet/frontend/chat.dart';
import 'package:vcet/frontend/firstpage.dart';
import 'package:vcet/frontend/firstpage1.dart';

import 'package:vcet/frontend/library.dart';
import 'package:vcet/frontend/menupage.dart';
import 'package:vcet/frontend/notification.dart';
import 'package:vcet/frontend/profile.dart';
import 'package:vcet/frontend/upload.dart';

class drawers extends StatefulWidget {
  @override
  _drawersState createState() => _drawersState();
}

class _drawersState extends State<drawers> {
  navHomePage() {
     Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  navProfile() {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const profile()));
    });
  }

  navLibrary() {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const librarys()));
    });
  }

  navBusRoute() {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const busroute()));
    });
  }

  navNotification() {
    setState(() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const notification()));
    });
  }

  navUpload() {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const upload()));
    });
  }

  navBottom() {
    setState(() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const bottomnavigation()));
    });
  }

  MenuItems currentItem = MenuItem.home;
  @override
  Widget build(BuildContext context) => ZoomDrawer(
      style: DrawerStyle.Style1,
      borderRadius: 40,
      angle: -10,
      slideWidth: MediaQuery.of(context).size.width * 0.7,
      showShadow: true,
      backgroundColor: Colors.orangeAccent,
      menuScreen: Builder(
        builder: (context) => menupage(
            currentItem: currentItem,
            onSelectedItem: (item) {
              setState(() => currentItem = item);
              ZoomDrawer.of(context)!.close();
            }),
      ),
      mainScreen: getscreen());

  Widget getscreen() {
    switch (currentItem) {
      case MenuItem.home:
        return const bottomnavigation();

      case MenuItem.profile:
        return profile();
      case MenuItem.busroute:
        return busroute();
      case MenuItem.library:
        return librarys();
      case MenuItem.notification:
        return notification();
      case MenuItem.upload:
        return upload();
      case MenuItem.chat:
        return HomePage();
      default:
        return bottomnavigation();
    }
  }
}
