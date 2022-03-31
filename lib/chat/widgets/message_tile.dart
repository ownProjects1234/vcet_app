import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vcet/colorClass.dart';
import 'package:vcet/frontend/others_profile.dart';

class MessageTile extends StatelessWidget {
  final String message;
  final String sender;
  final bool sentByMe;
  final String senderID;
  final DateTime date;

  const MessageTile(
      {Key? key,
      required this.date,
      required this.senderID,
      required this.message,
      required this.sender,
      required this.sentByMe})
      : super(key: key);
 
  @override
  Widget build(BuildContext context) {

    var format = new DateFormat("MMM dd kk:mm");
    return Container(
      padding: EdgeInsets.only(
        top: 2,
        bottom: 2,
        left: sentByMe ? 0 : 24,
        right: sentByMe ? 24 : 0,
      ),
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: sentByMe
            ? const EdgeInsets.only(left: 30)
            : EdgeInsets.only(right: 30),
        padding:
            const EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 12),
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
            borderRadius: sentByMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                    bottomLeft: Radius.circular(24))
                : const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                    bottomRight: Radius.circular(24))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             GestureDetector(
               onTap: (() => {
                 Navigator.push(context, MaterialPageRoute(builder: (context)=> userProfile(userId: senderID)))
               }),
               child: Text(sender.toUpperCase() +" • "+ format.format(date),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 13.0,
                      color: Colors.black54,
                      letterSpacing: -0.5)),
             ),
            const SizedBox(
              height: 3.0,
            ),
            Text(
              message,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                
                  ),
            )
          ],
        ),
      ),
    );
  }
}
