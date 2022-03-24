import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vcet/backend/models/user_info.dart';
import 'package:vcet/backend/providers/get_user_info.dart';
import 'package:vcet/chat/helper/helper_functions.dart';

final CollectionReference userRef =
    FirebaseFirestore.instance.collection('users');

updateProfilePic(String profileUrl) async {
  String? userId = await HelperFunctions.getUserIdSharedPreference();
  userRef.doc(userId).update({
    "photourl": profileUrl,
  });
  String? rollNo = await HelperFunctions.getUserIdSharedPreference();
  DocumentSnapshot doc = await userRef.doc(rollNo).get();
  currentUser = userInfo.fromDocument(doc);
}
