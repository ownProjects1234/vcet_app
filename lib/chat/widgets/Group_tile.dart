// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vcet/chat/pages/chat_page.dart';
import 'package:vcet/chat/services/database_service.dart';
import 'package:vcet/colorClass.dart';
import 'package:vcet/frontend/login.dart';

class Grouptiles extends StatefulWidget {
  final String username;
  final String groupId;
  final String groupName;
  final String admin;
  final String userId;
  const Grouptiles(
      {Key? key,
      required this.userId,
      required this.admin,
      required this.groupId,
      required this.groupName,
      required this.username})
      : super(key: key);

  @override
  _GrouptilesState createState() => _GrouptilesState();
}

class _GrouptilesState extends State<Grouptiles> {
  late QuerySnapshot searchResultSnapshot;
  bool isLoading = false;
  bool hasUserSearched = false;
  bool _isJoined = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _showScaffold(String message, $groupName) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: myColors.secondaryColor,
      duration: const Duration(milliseconds: 1500),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 17.0),
      ),
    ));
  }

  _joinValueInGroup(
      String userName, String groupId, String groupName, String admin) async {
    bool value = await DatabaseService(uid: widget.userId)
        .isUserJoined(groupId, groupName, userName);

    // setState(() {
    //   _isJoined = value;
    // });

    if (this.mounted) {
      setState(() {
        _isJoined = value;
      });
    }
  }

  Widget groupTile(
      String userName, String groupId, String groupName, String admin) {
    _joinValueInGroup(userName, groupId, groupName, admin);
    return GestureDetector(
      onTap: () {
        _isJoined
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatPage(
                          userId: widget.userId,
                          groupId: widget.groupId,
                          userName: widget.username,
                          groupName: widget.groupName,
                        )))
            : null;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        child: ListTile(
          
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
          leading: CircleAvatar(
            radius: 30.0,
            backgroundColor: myColors.secondaryColor,
            child: Text(groupName.substring(0, 1).toUpperCase(),
                style: TextStyle(color: Colors.white)),
          ),
          title: Text(
            groupName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text("Join the conversation as ${widget.username}",
              style: TextStyle(fontSize: 13.0)),
          trailing: InkWell(
              onTap: () async {
                await DatabaseService(uid: widget.userId)
                    .togglingGroupJoin(groupId, groupName, userName);
                if (_isJoined) {
                  setState(() {
                    _isJoined = !_isJoined;
                  });
                  _showScaffold('Successfully joined the group', "$groupName");
                } else {
                  setState(() {
                    _isJoined = !_isJoined;
                  });
                  _showScaffold('Left the group', "$groupName");
                }
              },
              child: _isJoined
                  ? Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.teal[300],
                          border: Border.all(color: myColors.secondaryColor!, width: 1.0)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: const Text(
                        'Joined',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: myColors.secondaryColor,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: const Text('Join',
                          style: TextStyle(color: Colors.white)),
                    )),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return groupTile(
        widget.username, widget.groupId, widget.groupName, widget.admin);
  }
}
