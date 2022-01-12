import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:vcet/frontend/busroute.dart';
import 'package:vcet/frontend/chat.dart';
import 'package:vcet/frontend/firstpage.dart';
<<<<<<< HEAD
import 'package:vcet/frontend/firstpage1.dart';
=======
>>>>>>> 67a04fba52b0145aa7cd3483ad47aad0a7215f44
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
<<<<<<< HEAD
        return const bottomnavigation();
=======
        return const firstpage();
>>>>>>> 67a04fba52b0145aa7cd3483ad47aad0a7215f44
      case MenuItem.profile:
        return const profile();
      case MenuItem.busroute:
        return const busroute();
      case MenuItem.library:
        return const librarys();
      case MenuItem.notification:
        return const notification();
      case MenuItem.upload:
        return const upload();
      case MenuItem.chat:
        return const chat();
      default:
<<<<<<< HEAD
        return const bottomnavigation();
=======
        return firstpage();
>>>>>>> 67a04fba52b0145aa7cd3483ad47aad0a7215f44
    }
  }
}
