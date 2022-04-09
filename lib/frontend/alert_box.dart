import 'dart:io';

import 'package:flutter/material.dart';
import 'package:vcet/backend/providers/get_user_info.dart';
import 'package:vcet/backend/update_profile_to_firestore.dart';
import 'package:vcet/frontend/notification.dart';
import 'package:vcet/frontend/queryPage.dart';

alertBox(String title, String content, String type, context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () => handleAlertCloseSubmit(type, context),
              /*Navigator.of(context).pop(true)*/
              child: Text('cancel'),
            ),
            TextButton(
              onPressed: () => handleAlertOkSubmit(type, context),
              /*Navigator.of(context).pop(true)*/
              child: Text('ok'),
            ),
          ],
        );
      });
}

handleAlertCloseSubmit(String type, context) {
  userRef.doc((currentUser?.rollNo)!).update({"$type": 0});
  firebasefirestore().getUserInfo(currentUser?.rollNo);
  Navigator.pop(context);
}

handleAlertOkSubmit(String type, context) {
  userRef.doc((currentUser?.rollNo)!).update({"$type": 0});
  firebasefirestore().getUserInfo(currentUser?.rollNo);

  if (type == 'alertCount') {
    Navigator.pop(context);
  } else if (type == 'subjCount') {
    Navigator.pop(context);
  } else if (type == 'queryCount') {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const queryPage()));
  } else if (type == 'noticeCount') {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                const notification(subj: "Notification", fromWhere: 'appBar')));
  }
}
