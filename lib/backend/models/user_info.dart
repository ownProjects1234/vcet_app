import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class userInfo {
  final String dob;
  final List groups;
  final String photourl;
  final String rollNo;
  final String staff;
  final List subj;
  final String name;
  final String email;
  final String major;
  final int postCount;

  userInfo({
    required this.postCount,
    required this.name,
    required this.email,
    required this.dob,
    required this.groups,
    required this.photourl,
    required this.rollNo,
    required this.staff,
    required this.subj,
    required this.major,
  });

  factory userInfo.fromDocument(DocumentSnapshot doc) {
    return userInfo(
        postCount: doc['postCount'],
        major: doc['major'],
        name: doc['name'],
        email: doc['email'],
        dob: doc['dob'],
        groups: doc['groups'],
        photourl: doc['photourl'],
        rollNo: doc['rollNo'],
        staff: doc['staff'],
        subj: doc['subj']);
  }
}
