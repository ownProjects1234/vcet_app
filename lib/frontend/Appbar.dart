// ignore: duplicate_ign
// ignore_for_file: non_constant_identifier_names, file_names

import 'package:vcet/frontend/login.dart';

import 'package:flutter/material.dart';

AppBar Appbars(String pagename) {
  return AppBar(
    title: Text(pagename),
    elevation: 15,
    backgroundColor: Colors.red,
    actions: [Icon(Icons.share), Icon(Icons.image)],
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(105), bottomRight: Radius.circular(105)),
    ),
    bottom:
        const PreferredSize(preferredSize: Size.fromHeight(120), child: SizedBox()),
  );
}
