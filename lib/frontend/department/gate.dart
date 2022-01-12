import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class Gate extends StatefulWidget {
  const Gate({Key? key}) : super(key: key);

  @override
  _GateState createState() => _GateState();
}

class _GateState extends State<Gate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.yellow,
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
                    image: AssetImage('images/project/gate.jpg'),
                    fit: BoxFit.cover,
                  ),
                  collapseMode: CollapseMode.pin,
                ),
                title: Text("G A T E"),
              )
            ];
          },
          body: Text('hi')),
    );
  }
}
