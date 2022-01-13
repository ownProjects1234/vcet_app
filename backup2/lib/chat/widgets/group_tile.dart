import 'package:flutter/material.dart';
import 'package:vcet/chat/pages/chat_page.dart';
import 'package:vcet/chat/services/database_service.dart';

class GroupTile extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;
  final String admin;

  // var _userName;

  const GroupTile(
      {Key? key,
      required this.groupId,
      required this.groupName,
      required this.admin,
      required this.userName})
      : super(key: key);

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    bool _isJoined = false;

    _joinValueInGroup(
        String userName, String groupId, String groupName, String admin) async {
      bool value = await DatabaseService(uid: userName)
          .isUserJoined(groupId, groupName, userName);

      setState(() {
        _isJoined = value;
      });
    }

    _joinValueInGroup(
      widget.userName,
      widget.groupId,
      widget.groupName,
      widget.admin,
    );
    void _showScaffold(String message, $groupName) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.blueAccent,
        duration: const Duration(milliseconds: 1500),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 17.0),
        ),
      ));
    }

    return GestureDetector(
      onTap: () {
        _isJoined
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatPage(
                          groupId: widget.groupId,
                          userName: widget.userName,
                          groupName: widget.groupName,
                        )))
            : null;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.blueAccent,
            child: Text(widget.groupName.substring(0, 1).toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white)),
          ),
          title: Text(widget.groupName,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text("Join the conversation as ${widget.userName}",
              style: TextStyle(fontSize: 13.0)),
          trailing: InkWell(
            child: _isJoined
                ? Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.black87,
                        border: Border.all(color: Colors.white, width: 1.0)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: const Text(
                      'Leave',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.blueAccent,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: const Text('Join',
                        style: TextStyle(color: Colors.white)),
                  ),
            onTap: () async {
              await DatabaseService(uid: widget.userName).togglingGroupJoin(
                  widget.groupId, widget.groupName, widget.userName);
              if (_isJoined) {
                
                _showScaffold(
                    'Successfully joined the group', "${widget.groupName}");
              } 
                _showScaffold('Left the group', "${widget.groupName}");
              }
            ,
          ),
        ),
      ),
    );
  }
}
