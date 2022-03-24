import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vcet/backend/models/user_info.dart';

import '../update_profile_to_firestore.dart';

userInfo? currentUser;

class firebasefirestore {
  getUserInfo(String? rollNo) async {
    DocumentSnapshot doc = await userRef.doc(rollNo).get();
    currentUser = userInfo.fromDocument(doc);
  }
}
