import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class Cs extends StatefulWidget {
  const Cs({Key? key}) : super(key: key);

  @override
  _CsState createState() => _CsState();
}

class _CsState extends State<Cs> {
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
                    image: AssetImage('images/project/civilservice.jpg'),
                    fit: BoxFit.cover,
                  ),
                  collapseMode: CollapseMode.pin,
                ),
                title: Text("CIVIL SERVICE"),
              )
            ];
          },
          body: Text('hi')),
    );
  }
}
