import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:vcet/colorClass.dart';
import 'package:vcet/frontend/drawers.dart';
import 'package:vcet/colorClass.dart';
import 'package:vcet/frontend/list_of_books.dart';

CollectionReference libRef = FirebaseFirestore.instance.collection('library');

class librarys extends StatefulWidget {
  const librarys({Key? key}) : super(key: key);

  @override
  _librarysState createState() => _librarysState();
}

class _librarysState extends State<librarys> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        backgroundColor: myColors.buttonColor,
        body: NestedScrollView(
            headerSliverBuilder: (context, isScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: myColors.secondaryColor,
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
                  title: const Text(
                    "L I B R A R Y",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ];
            },
            body: buildingLib()),
      ),
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

  Widget buildingLib() {
    return StreamBuilder(
      stream: libRef.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  String subjname = snapshot.data!.docs[index].id;
                  return GestureDetector(
                    child: Card(
                      margin: const EdgeInsets.all(5),
                      borderOnForeground: true,
                      semanticContainer: true,
                      color: Color.fromARGB(255, 212, 99, 93),
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(color: Colors.white70, width: 5),
                        borderRadius: BorderRadius.circular(20),
                      ),

                      elevation: 10,
                      // color: Colors.amber,
                      shadowColor: Colors.black,
                      child: ListTile(
                        leading: const Icon(
                          Icons.library_books_rounded,
                          color: Colors.white,
                        ),
                        title: Text(
                          subjname,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, letterSpacing: 2),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () async {
                      await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  listOfBooks(subjName: subjname)));
                    },
                  );
                })
            : Container();
      },
    );
  }
}