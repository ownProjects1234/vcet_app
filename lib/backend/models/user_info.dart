import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class userInfo {
  final String dob;
  final List groups;
  final String photourl;
  final String rollNo;
  final String staff;
  final List subj;

  userInfo({
    required this.dob,
    required this.groups,
    required this.photourl,
    required this.rollNo,
    required this.staff,
    required this.subj,
  });

  factory userInfo.fromDocument(DocumentSnapshot doc) {
    return userInfo(
        dob: doc['dob'],
        groups: doc['groups'],
        photourl: doc['photourl'],
        rollNo: doc['rollNo'],
        staff: doc['staff'],
        subj: doc['subj']);
  }
}
