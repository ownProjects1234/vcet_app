import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vcet/backend/counter.dart';
import 'package:vcet/backend/models/post_info.dart';

postInfo? currentpostCount;

class firestore {
  getPostCount() async {
    DocumentSnapshot doc = await counterRef.doc('count').get();
    currentpostCount = postInfo.fromDocument(doc);
  }
}
