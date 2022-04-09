// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:vcet/backend/update_profile_to_firestore.dart';

setUserDatas(String rollNo) {
  userRef.doc(rollNo).update({
    "groups": [],
    "postCount": 0,
    "subjCount": 0,
    'queryCount': 0,
    "alertCount": 0,
    "noticeCount": 0,
  });
}
