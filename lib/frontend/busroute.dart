import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:vcet/colorClass.dart';
import 'package:vcet/frontend/firstpage.dart';

class busroute extends StatefulWidget {
  const busroute({Key? key}) : super(key: key);

  @override
  _busrouteState createState() => _busrouteState();
}

class _busrouteState extends State<busroute> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, isScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: myColors.secondaryColor,
                  floating: true,
                  pinned: true,
                  expandedHeight: 200,
                  leading: IconButton(
                      onPressed: () => ZoomDrawer.of(context)!.toggle(),
                      icon: Icon(Icons.menu)),

                  // centerTitle: true,
                  flexibleSpace: const FlexibleSpaceBar(
                    centerTitle: true,
                    background: Image(
                      image: NetworkImage(
                          "https://www.collegelisttn.com/list_img/209/velammal-engg-college-5.jpg"),
                      fit: BoxFit.cover,
                    ),
                    collapseMode: CollapseMode.pin,
                  ),
                  title: Text("B U S R O U T E", style: TextStyle(fontWeight: FontWeight.bold),),
                )
              ];
            },
            body: Text('hi')),
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
            /*Navigator.of(context).pop(true)*/
            child: Text('Yes'),
          ),
        ],
      ),
    );

    return shouldpop ?? false;
  }
}
