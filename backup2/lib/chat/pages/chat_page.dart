import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vcet/chat/services/database_service.dart';
import 'package:vcet/chat/widgets/message_tile.dart';
import 'package:vcet/frontend/login.dart';

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
  loginpage user = loginpage();

  late Stream<QuerySnapshot> _chats;
  TextEditingController messageEditingController = TextEditingController();

  Widget _chatMessages() {
    return StreamBuilder(
      stream: _chats,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                    message: snapshot.data!.docs[index].data()['message'],
                    sender: snapshot.data!.docs[index].data()['sender'],
                    sentByMe: widget.userName ==
                        snapshot.data!.docs[index].data()['sender'],
                  );
                },
              )
            : Container();
      },
    );
  }

  _sendMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageEditingController.text,
        "sender": widget.userName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseService(uid: widget.userName)
          .sendMessage(widget.groupId, chatMessageMap);

      messageEditingController.clear();

      setState(() {
        messageEditingController.text = '';
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    DatabaseService(uid: widget.userName).getChats(widget.groupId).then((val) {
      setState(() {
        _chats = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.groupName,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
        elevation: 0.0,
      ),
      body: Container(
        child: Stack(
          children: [
            _chatMessages(),
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                color: Colors.grey[700],
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: messageEditingController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          hintText: "Send a message.....",
                          hintStyle:
                              TextStyle(color: Colors.white38, fontSize: 16),
                          border: InputBorder.none),
                    )),
                    const SizedBox(width: 12.0),
                    GestureDetector(
                      onTap: () {
                        _sendMessage();
                        messageEditingController.clear();
                      },
                      child: Container(
                        height: 50.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(50)),
                        child: const Center(
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
