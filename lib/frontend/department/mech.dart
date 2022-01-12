import 'package:flutter/material.dart';

class Mech extends StatefulWidget {
  const Mech({Key? key}) : super(key: key);

  @override
  _MechState createState() => _MechState();
}

class _MechState extends State<Mech> {
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
                    image: AssetImage('images/project/mech.jpg'),
                    fit: BoxFit.cover,
                  ),
                  collapseMode: CollapseMode.pin,
                ),
                title: Text("M E C H"),
              )
            ];
          },
          body: Text('hi')),
    );
  }
}
