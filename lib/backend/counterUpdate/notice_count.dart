import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vcet/backend/models/user_info.dart';
import 'package:vcet/backend/providers/get_user_info.dart';
import 'package:vcet/backend/update_profile_to_firestore.dart';

updateNoticeCount() async {
  QuerySnapshot staffSnapshot =
      await FirebaseFirestore.instance.collection('users').get();

  print(staffSnapshot);
  List<userInfo> rollNO;

  rollNO = staffSnapshot.docs.map((doc) => userInfo.fromDocument(doc)).toList();

  print("RollNo from query $rollNO");

  for (var roll in rollNO) {
    DocumentSnapshot getUser = await userRef.doc(roll.rollNo).get();
    print("hello");
    int count = getUser.get('noticeCount') + 1;
    print("count $count");

    userRef.doc(roll.rollNo).update({"noticeCount": count});
  }
}
