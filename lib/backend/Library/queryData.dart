// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:vcet/backend/providers/get_user_info.dart';

class DataController extends GetxController {
  Future queryData(String enteredString, String subj) async {
    return FirebaseFirestore.instance
        .collection("library")
        .doc(subj)
        .collection('books')
        .where('name', isGreaterThanOrEqualTo: enteredString).get();
  }
}
