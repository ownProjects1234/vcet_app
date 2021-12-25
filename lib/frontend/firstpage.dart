import 'dart:io';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vcet/frontend/Appbar.dart';


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
      Icons.update,
      size: 30,
    ),
    const Icon(Icons.file_upload, size: 30),
    const Icon(Icons.home, size: 30),
    const Icon(Icons.quiz, size: 30),
    const Icon(Icons.chat, size: 30),
  ];
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          color: Colors.red,
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
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                            crossAxisCount: 3,
                            children: <Widget>[
                              Card(
                                child: Column(
                                  children:  [
                                    Container(
                                    //  width: 
                                 //     height: MediaQuery.of(context).size.height-25,
                                      child: const Image(
                                        image: AssetImage(
                                            'images/project/it1.jpg'),
                                       // height: double.infinity,
                                        //width: double.infinity,
                                      
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    //   Text("ECE")
                                  ],
                                ),
                              ),
                              Column(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  const Image(
                                    image: AssetImage(
                                        'images/project/ece1.jpg'),
                                   // height: 114,
                                    //width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                 const Text(
                                    "ECE"
                                  )
                                ],
                              ),
                              Container(
                                //  padding: const EdgeInsets.all(8),
                                child: Column(
                                  children: const [
                                    Image(
                                      image:
                                          AssetImage('images/project/civil2.jpg'),
                                      //height: 114,
                                      //width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                               // color: Colors.teal[300],
                              ),
                              Container(
                                child: Column(
                                  children: const [
                                    Image(
                                        image:
                                            AssetImage("images/project/cse1.jpg"))
                                  ],
                                ),
                              ),
                              Container(),
                              Container(),
                            ],
                          ),
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          height: 60,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 20),
                                    blurRadius: 50,
                                    color: Color(0XFF0C9869).withOpacity(0.23))
                              ]),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
        appBar: buildAppbar(),
        drawer: Drawer(),
        bottomNavigationBar: Theme(
          data: Theme.of(context)
              .copyWith(iconTheme: IconThemeData(color: Color(0xFF03C4046))),
          child: CurvedNavigationBar(
            items: items,
            index: index,
            onTap: (index) => setState(() => this.index = index),
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 300),
            height: 60,
            backgroundColor: Colors.red,
            color: Colors.white,
            buttonBackgroundColor: Colors.red.shade100,
          ),
        ),
      ),
    );
  }

  AppBar buildAppbar() {
    return AppBar(
      title: Text("V C E T"),
      elevation: 0,
      backgroundColor: Color(0XFF0C9869),
      // leading: IconButton(onPressed: () {}, icon: Icon(Icons.image)),
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
