import 'package:flutter/material.dart';

class appbar extends StatefulWidget {
  const appbar({Key? key}) : super(key: key);

  @override
  _appbarState createState() => _appbarState();
}

class _appbarState extends State<appbar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return <Widget>[
              const SliverAppBar(
                backgroundColor: Colors.yellow,
                floating: true,
                pinned: true,
                expandedHeight: 200,
                // centerTitle: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: Image(
                    image: AssetImage('images/project/ece.jpg'),
                    fit: BoxFit.cover,
                  ),
                  collapseMode: CollapseMode.pin,
                ),
                title: Text("AppBar"),
              )
            ];
          },
          body: Text('hi')),
    );
  }
}
