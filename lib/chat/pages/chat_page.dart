import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vcet/chat/helper/helper_functions.dart';
import 'package:vcet/chat/services/database_service.dart';
import 'package:vcet/chat/widgets/message_tile.dart';
import 'package:vcet/colorClass.dart';
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
  File? image;
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      //print(image);

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    final imagetem = image!.readAsBytesSync();
    HelperFunctions.saveBgPicKeySharedPreferenceKey(
        HelperFunctions.base64String(imagetem));
  }

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
    getInfo();
  }

  Image? Img;

  getInfo() async {
    HelperFunctions.getBgPicKeySharedPreferences().then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        Img = HelperFunctions.imageFrom64BaseString(value);
      });
    });
  }

  Widget _chatMessages() {
    return StreamBuilder(
      stream: _chats,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                controller: listScrollController,
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

  ScrollController listScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: myColors.secondaryColor,
        elevation: 0.0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(
                        Icons.picture_in_picture,
                        // size: 20,
                        color: Colors.black,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: ((builder) => bottomSheet()));
                          },
                          child: Text("Change Background Image"),
                        ),
                      )
                    ],
                  ),
                )
              ],
              child: Icon(Icons.more_vert),
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: img()!.image, fit: BoxFit.cover)),
        child: Stack(
          children: <Widget>[
            //   Text("All the message in this group is monitored by Admin"),
            Padding(
              padding: const EdgeInsets.only(bottom: 80.0),
              child: Container(child: _chatMessages()),
            ),
            // Container(),
            Container(
              alignment: Alignment.bottomCenter,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 10.0),
                color: Colors.transparent,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Card(
                        color: Colors.black54,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.all(7.0),
                        child: TextField(
                          controller: messageEditingController,
                          style: const TextStyle(
                            color: Colors.white,
                          ),

                          //maxLength: 40,

                          decoration: const InputDecoration(
                              hintText: "   Send a message ...",
                              hintStyle: TextStyle(
                                color: Colors.white38,
                                fontSize: 16,
                              ),
                              border: InputBorder.none),
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
                            color: Colors.black87,
                            borderRadius: BorderRadius.circular(50)),
                        child: const Center(
                            child: Icon(Icons.send, color: Colors.white)),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     if (listScrollController.hasClients) {
      //       final position = listScrollController.position.maxScrollExtent;
      //       listScrollController.jumpTo(position);
      //     }
      //   },
      //   //isExtended: true,
      //   tooltip: "Scroll to Bottom",
      //   child:const Icon(Icons.arrow_downward),
      // ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const Text(
            "Choose profile photo",
            style: TextStyle(fontSize: 20.0),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        pickImage(ImageSource.camera);
                        // HelperFunctions.savePicKeySharedPreferences(
                        //     HelperFunctions.base64String(image!.readAsBytesSync()));
                      },
                      icon: const Icon(
                        Icons.camera,
                        color: Colors.black,
                      )),
                  GestureDetector(
                    onTap: () {
                      pickImage(ImageSource.camera);
                    },
                    child: const Text(
                      "Camera",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(left: 20)),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        pickImage(ImageSource.gallery);
                        // HelperFunctions.savePicKeySharedPreferences(
                        //     HelperFunctions.base64String(image!.readAsBytesSync()));
                      },
                      icon: const Icon(
                        Icons.image,
                        color: Colors.black,
                      )),
                  GestureDetector(
                    onTap: () {
                      pickImage(ImageSource.gallery);
                    },
                    child: const Text(
                      "Gallery",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Image? img() {
    if (image == null) {
      if (Img == null) {
        return const Image(
          image: AssetImage('images/chatbackground.png'),
        );
      } else {
        return Img;
      }
    } else {
      return Image.file(image!, fit: BoxFit.cover);
    }
  }
}
