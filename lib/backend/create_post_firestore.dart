import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vcet/backend/providers/get_user_info.dart';

final CollectionReference postsRef =
    FirebaseFirestore.instance.collection('posts');
final int timestamp = DateTime.now().millisecondsSinceEpoch;

createPostInFirestore(
    String mediaUrl, String description, String destination,String fileName, String subj, String uniqueId) {
  postsRef.doc(fileName+"_"+uniqueId).set({
    "profileUrl": currentUser?.photourl,
    "destination": destination,
    "userId": currentUser?.rollNo,
 //   "count": counter,
   // "username": 
   "mediaUrl": mediaUrl,
   "description": description,
   "timestamp": timestamp,
   "subj": subj,
   "userName": currentUser?.name
  });
}
