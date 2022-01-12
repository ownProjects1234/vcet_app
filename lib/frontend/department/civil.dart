import 'package:flutter/material.dart';

class Civil extends StatefulWidget {
  const Civil({Key? key}) : super(key: key);

  @override
  _CivilState createState() => _CivilState();
}

class _CivilState extends State<Civil> {
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
                    image: AssetImage('images/project/civil.jpg'),
                    fit: BoxFit.cover,
                  ),
                  collapseMode: CollapseMode.pin,
                ),
                title: Text("C I V I L"),
              )
            ];
          },
          body: Text('hi')),
    );
  }
}
