import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vcet/backend/models/user_info.dart';
import 'package:vcet/backend/providers/get_user_info.dart';
import 'package:vcet/backend/update_profile_to_firestore.dart';

import '../chat/helper/helper_functions.dart';

updateUserInfo(String name, String email, String majorField) async {
  userRef.doc(currentUser?.rollNo).update({
    "name": name,
    "email": email,
    "major": majorField,
  });
  String? rollNo = await HelperFunctions.getUserIdSharedPreference();
  DocumentSnapshot doc = await userRef.doc(rollNo).get();
  currentUser = userInfo.fromDocument(doc);
}
