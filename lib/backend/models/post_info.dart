import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class postInfo {
  int counter;
  postInfo({
    required this.counter,
  });
  factory postInfo.fromDocument(DocumentSnapshot doc) {
    return postInfo(counter: doc['counter']);
  }
}
