import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class Eee extends StatefulWidget {
  const Eee({Key? key}) : super(key: key);

  @override
  _EeeState createState() => _EeeState();
}

class _EeeState extends State<Eee> {
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
                    image: AssetImage('images/project/eee.jpg'),
                    fit: BoxFit.cover,
                  ),
                  collapseMode: CollapseMode.pin,
                ),
                title: Text("E E E"),
              )
            ];
          },
          body: Text('hi')),
    );
  }
}
