import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vcet/chat/widgets/message_tile.dart';

class ChatPage extends StatefulWidget {
  final String groupId;
  final String userName;
  final String groupName;
  const ChatPage({
    Key? key,
    required this.groupId,
    required this.userName,
    required this.groupName,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late Stream<QuerySnapshot> _chats;

  Widget _chatMessages() {
    return StreamBuilder(
      stream: _chats,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.lenght,
                itemBuilder: (context, index) {
                  return MessageTile(
                    message: snapshot.data!.docs[index].data['message'],
                    sender: snapshot.data!.docs[index].data['sender'],
                    sentByMe: widget.userName ==
                        snapshot.data!.docs[index].data['sender'],
                  );
                },
              )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
