import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vcet/chat/helper/helper_functions.dart';
import 'package:vcet/chat/pages/search_page.dart';
import 'package:vcet/chat/services/database_service.dart';
import 'package:vcet/chat/widgets/Group_tile.dart';
import 'package:vcet/frontend/drawers.dart';

import 'package:vcet/frontend/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _groupName = " ";
  String _userName = " ";
  String _rollNo = " ";
  //late Stream<List<DocumentSnapshot>> _groups;

  loginpage user = loginpage();

  @override
  void initState() {
    super.initState();
    _getUserAuthAndJoinedGroups();
  }

  _getUserAuthAndJoinedGroups() async {
    HelperFunctions.getUserNameSharedPreferences().then((value) {
      setState(() {
        _userName = value;
      });
    });
    print(_userName);

    // await DatabaseService(uid: _userName).getUserGroups().then((snapshots) {
    //   setState(() {
    //     // _groups = snapshots as Stream<List<DocumentSnapshot>>;
    //   });
    //   print(_groups);
    // });
    HelperFunctions.getUserIdSharedPreference().then((value) {
      setState(() {
        _rollNo = value!;
      });
    });
  }

  Widget noGroupWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
              onTap: () {
                _popupDialog(context);
              },
              child:
                  Icon(Icons.add_circle, color: Colors.grey[700], size: 75.0)),
          const SizedBox(height: 20.0),
          const Text(
              "You've not joined any group, tap on the 'add' icon to create a group or search for groups by tapping on the search button below."),
        ],
      ),
    );
  }

  // Future getGroups() async {
  //   var firestore = FirebaseFirestore.instance;
  //   QuerySnapshot qn = await firestore.collection('groups').get();
  //   return qn.docs;
  // }

  Widget groupList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('groups').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
            children: snapshot.data!.docs.map((document) {
          return Grouptiles(
            username: _userName,
            groupId: (document['groupId']).toString(),
            groupName: (document['groupName']).toString(),
            admin: (document['admin']).toString(),
          );
        }).toList());
      },
    );
  }

  // String _destructureId(String res) {
  //   return res.substring(0, res.indexOf('_'));
  // }

  // String _destructureName(String res) {
  //   return res.substring(res.indexOf('_') + 1);
  // }

  void _popupDialog(BuildContext context) {
    Widget cancelButton = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Cancel'));

    Widget createButton = TextButton(
      child: Text('Create'),
      onPressed: () async {
        if (_groupName != null) {
          await HelperFunctions.getUserNameSharedPreferences().then((value) {
            DatabaseService(uid: _userName).createGroup(value, _groupName);
          });
          Navigator.of(context).pop();
        }
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Create a group"),
      content: TextField(
        onChanged: (val) {
          _groupName = val;
        },
        style:
            const TextStyle(fontSize: 15.0, height: 2.0, color: Colors.black),
      ),
      actions: [
        cancelButton,
        createButton,
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     'Groups',
      //     style: TextStyle(
      //         color: Colors.white, fontSize: 27.0, fontWeight: FontWeight.bold),
      //   ),
      //   backgroundColor: Colors.black87,
      //   elevation: 0.0,
      //   actions: [
      //     IconButton(
      //       padding: const EdgeInsets.symmetric(horizontal: 20.0),
      //       icon: const Icon(Icons.search, color: Colors.white, size: 25.0),
      //       onPressed: () {
      //         Navigator.of(context).push(
      //             MaterialPageRoute(builder: (context) => const SearchPage()));
      //       },
      //     )
      //   ],
      // ),
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
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT14EvaKfwyR5Kv-a2NsXOxzcwzloGChuAK_NhS8KeLoEGN6-UmcnZ4UxcVAGCpEVSbguQ&usqp=CAU"),
                    fit: BoxFit.cover,
                  ),
                  collapseMode: CollapseMode.pin,
                ),
                title: Text("GROUPS"),
              )
            ];
          },
        
        body: groupList()),
     
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _popupDialog(context);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30.0,
        ),
        backgroundColor: Colors.grey[700],
        elevation: 0.0,
      ),
    );
  }
}
