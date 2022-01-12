import 'package:flutter/material.dart';

class Cse extends StatefulWidget {
  const Cse({Key? key}) : super(key: key);

  @override
  _CseState createState() => _CseState();
}

class _CseState extends State<Cse> {
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
                    image: AssetImage('images/project/cse.jpg'),
                    fit: BoxFit.cover,
                  ),
                  collapseMode: CollapseMode.pin,
                ),
                title: Text("C S E"),
              )
            ];
          },
          body: Text('hi')),
    );
  }
}
