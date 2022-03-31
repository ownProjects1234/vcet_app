//updating the count of post
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vcet/backend/models/user_info.dart';

import '../providers/get_user_info.dart';
import '../update_profile_to_firestore.dart';
int postCount = 0;
updatePostCount() async {
  postCount = ((currentUser?.postCount)! + 1);
  userRef.doc(currentUser?.rollNo).update({
    "postCount": postCount,
  });
  DocumentSnapshot doc = await userRef.doc(currentUser?.rollNo).get();
  currentUser = userInfo.fromDocument(doc);
}
