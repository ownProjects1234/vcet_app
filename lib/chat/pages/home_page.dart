import 'package:flutter/material.dart';
import 'package:vcet/chat/helper/helper_functions.dart';
import 'package:vcet/chat/services/database_service.dart';
import 'package:vcet/frontend/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _groupName = '';
  String _userName = '';
  String _rollNo = '';
  late Stream _groups;

  loginpage user = loginpage();

  @override
  void initState() {
    // TODO: implement initState

    _getUserAuthAndJoinedGroups();
  }

    _getUserAuthAndJoinedGroups() async {
    await HelperFunctions.getUserNameSharedPreferences().then((value) {
      setState(() {
        _userName = value!;
      });
    });

    DatabaseService(uid: user.UserId()).getUserGroups().then((snapshots) {
      setState(() {
        _groups = snapshots;
      });
    });
    await HelperFunctions.getUserIdSharedPreference().then((value) {
      setState(() {
        _rollNo = value!;
      });
    });
  }

  Widget noGroupWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
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
          SizedBox(height: 20.0),
          Text(
              "You've not joined any group, tap on the 'add' icon to create a group or search for groups by tapping on the search button below."),
        ],
      ),
    );
  }

  // Widget groupList() {
  //   return StreamBuilder(
  //       stream: _groups,
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData) {
  //           if (snapshot.data!['_groups'] != null) {
  //             if (snapshot.data['groups'].lenght != 0) {
  //               return ListView.builder(
  //                 itemCount: snapshot.data['groups'].length,
  //                 shrinkWrap: true,
  //                itemBuilder: (BuildContext context, index) {
  //                  int reqIndex = snapshot.data['groups'].length - index -1;
  //                  return GroupTile(userName: snapshot.data['fullName'], groupId: _destructureId());
  //                 };
  //               );
  //             }
  //           }
  //         }
  //       });
  // }

  String _destructureId(String res) {
    return res.substring(0, res.indexOf('_'));
  }

  String _destructureName(String res) {
    return res.substring(res.indexOf('_') + 1);
  }

  void _popupDialog(BuildContext context) {
    Widget cancelButton = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('Cancel'));

    Widget createButton = TextButton(
      child: Text('Create'),
      onPressed: () async {
        if (_groupName != null) {
          await HelperFunctions.getUserNameSharedPreferences().then((value) {
            DatabaseService(uid: user.UserId()).createGroup(value!, _groupName);
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
    return Container();
  }
}
