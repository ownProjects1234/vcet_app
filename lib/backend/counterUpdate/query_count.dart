import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vcet/backend/models/user_info.dart';
import 'package:vcet/backend/providers/get_user_info.dart';
import 'package:vcet/backend/update_profile_to_firestore.dart';

updateQueryCount(String subj) async {
  QuerySnapshot staffSnapshot = await FirebaseFirestore.instance
      .collection('users')
      .where('staff', isEqualTo: "true")
      .get();

  print(staffSnapshot);
  List<userInfo> rollNO;
  List<int> q_count;
  rollNO = staffSnapshot.docs.map((doc) => userInfo.fromDocument(doc)).toList();

  q_count = (staffSnapshot.docs
      .map((doc) => userInfo.fromDocument(doc).queryCount)).toList();

  print("RollNo from query $rollNO");

  for (var roll in rollNO) {
    DocumentSnapshot getUser = await userRef.doc(roll.rollNo).get();
    List subjs = getUser.get('subj').map((field) => field).toList();
    print('printing the subjs $subjs of $roll');
    int count = 0;
    subjs.forEach((element) {
      if (subj == element) {
        count = getUser.get('queryCount') + 1;
        print("count $count");
      }
    });

    userRef.doc(roll.rollNo).update({"queryCount": count});
  }
}
