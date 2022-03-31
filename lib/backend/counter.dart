import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final CollectionReference counterRef =
    FirebaseFirestore.instance.collection('counter');

createCounter(int counter) {
  counterRef.doc('count').update({
    'postCount': counter,
  });
}
