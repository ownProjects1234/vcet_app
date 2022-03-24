import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vcet/backend/update_profile_to_firestore.dart';
import 'package:vcet/colorClass.dart';

class MessageTile extends StatefulWidget {
  final String message;
  final String sender;
  final bool sentByMe;
  final String senderId;
  final DateTime date;
  const MessageTile(
      {Key? key,
      required this.date,
      required this.senderId,
      required this.message,
      required this.sender,
      required this.sentByMe})
      : super(key: key);

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  String? profileID;

  @override
  void initState() {
    
    super.initState();
    
    
  }

 
  var format = new DateFormat("yMd");


  @override
  Widget build(BuildContext context) {


    return Container(
      padding: EdgeInsets.only(
        top: 4,
        bottom: 4,
        left: widget.sentByMe ? 0 : 24,
        right: widget.sentByMe ? 24 : 0,
      ),
      alignment: widget.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: widget.sentByMe
            ? const EdgeInsets.only(left: 30)
            : EdgeInsets.only(right: 30),
        padding:
            const EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(
                  4.0,
                  4.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 1.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ), //BoxShadow
            ],
            color: myColors.secondaryColor,
            borderRadius: widget.sentByMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : const BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: (35 / 2) + 2,
                  backgroundColor: Colors.black,
                  child: CircleAvatar(
                    child: Container(
                      decoration: BoxDecoration(),
                    ),
                    radius: 35 / 2,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(widget.senderId)
                  ),
                ),
               const SizedBox(
                  width: 10,
                ),
                Text(widget.sender.toUpperCase(),
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: 13.0,
                        color: Colors.black54,
                        letterSpacing: -0.5)),
                      const  SizedBox(
                  width: 5,
                ),
                Text('•'),
                   const SizedBox(
                  width: 5,
                ),
                Text(format.format(widget.date),
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: 13.0,
                        color: Colors.black54,
                        letterSpacing: -0.5)),
              ],
            ),
            const SizedBox(
              height: 7.0,
            ),
            Text(
              widget.message,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 17.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
