import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class librarys extends StatefulWidget {
  const librarys({Key? key}) : super(key: key);

  @override
  _librarysState createState() => _librarysState();
}

class _librarysState extends State<librarys> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Color(0XFF0C9869),
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
                        "https://images.unsplash.com/photo-1507842217343-583bb7270b66?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZnJlZSUyMGxpYnJhcnl8ZW58MHx8MHx8&w=1000&q=80"),
                    fit: BoxFit.cover,
                  ),
                  collapseMode: CollapseMode.pin,
                ),
                title: Text("L I B R A R Y"),
              )
            ];
          },
          body: Text('hi')),
    );
  }
}
