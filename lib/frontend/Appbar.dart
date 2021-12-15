// ignore: duplicate_ign
import 'package:vcet/frontend/login.dart';

import 'package:flutter/material.dart';

AppBar Appbars(String pagename) {
  return AppBar(
    title: Text(pagename),
    elevation: 15,
    backgroundColor: Colors.red,
    actions: [Icon(Icons.share), Icon(Icons.image)],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(105), bottomRight: Radius.circular(105)),
    ),
    bottom:
        PreferredSize(preferredSize: Size.fromHeight(120), child: SizedBox()),
  );
}
