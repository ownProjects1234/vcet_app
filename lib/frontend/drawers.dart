import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:vcet/frontend/firstpage.dart';
import 'package:vcet/frontend/menupage.dart';

class drawers extends StatefulWidget {
  @override
  _drawersState createState() => _drawersState();
}

class _drawersState extends State<drawers> {
  @override
  Widget build(BuildContext context) => ZoomDrawer(
      style: DrawerStyle.Style1,
      menuScreen: menupage(),
      mainScreen: firstpage());
}
