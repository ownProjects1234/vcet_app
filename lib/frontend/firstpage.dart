import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:vcet/frontend/drawers.dart';
import 'package:vcet/frontend/menuwidget.dart';

class firstpage extends StatefulWidget {
  const firstpage({Key? key}) : super(key: key);

  @override
  _firstpageState createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  int index = 2;
  var value = 120.0;

  @override
  final items = <Widget>[
    const Icon(
      Icons.security_update_warning_sharp,
      size: 30,
    ),
    const Icon(Icons.upload_file_outlined, size: 30),
    const Icon(Icons.home_outlined, size: 30),
    const Icon(Icons.quiz_outlined, size: 30),
    const Icon(Icons.chat_sharp, size: 30),
  ];
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/project/pldEkV.jpg"),
                  fit: BoxFit.fill)
              //  gradient: LinearGradient(
              //   colors: [Colors.pinkAccent, Colors.red, Colors.black])
              ),
          child: Column(
            children: [
              Container(
                height: size.height * 0.74,
                child: Stack(
                  children: [
                    Container(
                      height: size.height * 0.2 - 30,
                      decoration: const BoxDecoration(
                          color: Color(0xFF0C9869),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(36),
                              bottomRight: Radius.circular(36))),
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        top: 8,
                        child: Container(
                          child: GridView.count(
                            primary: false,
                            padding: const EdgeInsets.only(
                                top: 20, bottom: 20, left: 8, right: 8),
                            crossAxisSpacing: 3,
                            mainAxisSpacing: 12,
                            crossAxisCount: 3,
                            children: <Widget>[
                              buildCard("ece", "ECE"),
                              buildCard("civil", "CIVIL"),
                              buildCard("eee", "EEE"),
                              buildCard("it", "IT"),
                              buildCard("cse", "CSE"),
                              buildCard("mech", "MECHANICAL"),
                              buildCard("gate", "GATE"),
                              buildCard("civilservice", "CIVIL SERVICE")
                            ],
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          //  height: 10,
                          //  width: double.infinity,
                          decoration: BoxDecoration(
                              image: const DecorationImage(
                                  image: AssetImage("images/project/ece.jpg"),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Colors.black45, BlendMode.darken)),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(0, 20),
                                    blurRadius: 50,
                                    color: const Color(0XFF0C9869)
                                        .withOpacity(0.23))
                              ]),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
        appBar: buildAppbar(),
        // drawer: drawers(),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              iconTheme: const IconThemeData(color: Color(0xff03c4046))),
          child: CurvedNavigationBar(
            items: items,
            index: index,
            onTap: (index) => setState(() => this.index = index),
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 300),
            height: 60,
            backgroundColor: Colors.transparent,
            buttonBackgroundColor: Colors.red.shade100,
          ),
        ),
      ),
    );
  }

  AppBar buildAppbar() {
    return AppBar(
      title: const Text("V C E T"),
      elevation: 0,
      backgroundColor: const Color(0XFF0C9869),
      leading: MenuWidget(),
    );
  }
}

Card buildCard(String pic, String name) {
  return Card(
    elevation: 10.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    //  padding: const EdgeInsets.all(8),
    child: Column(
      children: [
        Image(
          image: AssetImage('images/project/$pic.jpg'),
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
        ),
        const SizedBox(height: 7),
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        )
      ],
    ),
  );
}
