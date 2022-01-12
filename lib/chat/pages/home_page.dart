import 'package:flutter/material.dart';
import 'package:vcet/chat/helper/helper_functions.dart';
import 'package:vcet/chat/pages/search_page.dart';
import 'package:vcet/chat/services/database_service.dart';
import 'package:vcet/chat/widgets/group_tile.dart';
import 'package:vcet/frontend/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _groupName;
  String _userName = '';
  String _rollNo = '';
  late Stream _groups;

  loginpage user = loginpage();

  @override
  void initState() {
    super.initState();
    _getUserAuthAndJoinedGroups().whenComplete(() {
      setState(() {});
    });
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

  Widget groupList() {
    return StreamBuilder(
        stream: _groups,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['groups'] != null) {
              if (snapshot.data['groups'].length != 0) {
                return ListView.builder(
                  itemCount: snapshot.data['groups'].lenght,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    int reqIndex = snapshot.data['groups'].lenght - index - 1;
                    return GroupTile(
                        groupId:
                            _destructureId(snapshot.data['groups'][reqIndex]),
                        groupName:
                            _destructureName(snapshot.data['groups'][reqIndex]),
                        userName: snapshot.data['fullName']);
                  },
                );
              } else {
                return noGroupWidget();
              }
            } else {
              return noGroupWidget();
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Groups',
          style: TextStyle(
              color: Colors.white, fontSize: 27.0, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black87,
        elevation: 0.0,
        actions: [
          IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            icon: const Icon(Icons.search, color: Colors.white, size: 25.0),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SearchPage()));
            },
          )
        ],
      ),
      body: groupList(),
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
