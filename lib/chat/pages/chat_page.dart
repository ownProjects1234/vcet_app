import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vcet/chat/services/database_service.dart';
import 'package:vcet/chat/widgets/message_tile.dart';
import 'package:vcet/frontend/login.dart';

class ChatPage extends StatefulWidget {
  final String userId;
  final String groupId;
  final String userName;
  final String groupName;
  const ChatPage({
    Key? key,
    required this.userId,
    required this.groupId,
    required this.userName,
    required this.groupName,
  }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  loginpage user = loginpage();

  Stream<QuerySnapshot>? _chats;
  TextEditingController messageEditingController = TextEditingController();

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   messageEditingController.dispose();
  // }
    @override
  void initState() {
    // TODO: implement initState

    DatabaseService(uid: widget.userId).getChats(widget.groupId).then((val) {
      setState(() {
        _chats = val;
      });
    });
  }

  Widget _chatMessages() {
    return StreamBuilder(
      stream: _chats,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  reverse: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return MessageTile(
                      message: snapshot.data!.docs[index].data()['message'],
                      sender: snapshot.data!.docs[index].data()['sender'],
                      sentByMe: widget.userName ==
                          snapshot.data!.docs[index].data()['sender'],
                    );
                  },
                ),
              )
            : Container();
      },
    );
  }

  _sendMessage() {
    if (messageEditingController.text.trim().isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageEditingController.text.trim(),
        "sender": widget.userName,
        "time": DateTime.now().millisecondsSinceEpoch,
      };

      // DatabaseService(uid: widget.userId)
      //     .sendMessage(widget.groupId, chatMessageMap);

      setState(() {
        DatabaseService(uid: widget.userId)
            .sendMessage(widget.groupId, chatMessageMap);
        // messageEditingController.clear();
        messageEditingController.text = '';
      });
    }
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
      body: Column(
        children: [ 
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: _chatMessages()),
          Row(
            children: [
              Expanded(
                child: Card(
                  color: Colors.black54,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.all(30.0),
                  
                  child: TextField(
                    
                    controller: messageEditingController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                        hintText: "Send a message.....",
                        hintStyle:
                            TextStyle(color: Colors.black, fontSize: 16),
                        border: InputBorder.none
                        
                        ),
                  ),
                ),
              ),
              const SizedBox(width: 12.0),
              GestureDetector(
                onTap: () {
                  _sendMessage();
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
          )
        ],
      ),
    );
  }
  
}
