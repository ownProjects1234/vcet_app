import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final String uid;
  DatabaseService({
    required this.uid,
  });

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection('groups');

  Future updateUserdata(String fullName, String rollNo, String password) async {
    return await userCollection.doc(uid).set({
      'name': fullName,
      'rollNo': rollNo,
      'dob': password,
      'groups': [],
      'profilePic': ''
    });
  }

  Future createGroup(String userName, String groupName) async {
    DocumentReference groupDocRef = await groupCollection.add({
      'groupName': groupName,
      'groupIcon': '',
      'admin': userName,
      'members': [],
      'groupId': '',
      'recentMessage': '',
      'recentMessageSender': '',
    });

    await groupDocRef.update({
      'members': FieldValue.arrayUnion([uid + '_' + userName]),
      'groupId': groupDocRef.id
    });

    DocumentReference userDocRef = userCollection.doc(uid);
    return await userDocRef.update({
      'groups': FieldValue.arrayUnion([groupDocRef.id + '_' + groupName])
    });
  }

  Future togglingGroupJoin(
      String groupId, String groupName, String userName) async {
    DocumentReference userDocRef = userCollection.doc(uid);
    DocumentSnapshot userDocSnapshot = await userDocRef.get();

    DocumentReference groupDocRef = groupCollection.doc(groupId);

    List<dynamic> groups = await userDocSnapshot.get('groups');

    if (groups.contains(groupId + '_' + groupName)) {
      await userDocRef.update({
        'groups': FieldValue.arrayRemove([groupId + '_' + groupName])
      });

      await groupDocRef.update({
        'members': FieldValue.arrayRemove([uid + '_' + userName])
      });
    } else {
      await userDocRef.update({
        'groups': FieldValue.arrayUnion([groupId + '_' + groupName])
      });

      await groupDocRef.update({
        'members': FieldValue.arrayUnion([uid + '_' + userName])
      });
    }
  }

  Future<bool> isUserJoined(
      String groupId, String groupName, String userName) async {
    DocumentReference userDocRef = userCollection.doc(uid);
    DocumentSnapshot userDocSnapshot = await userDocRef.get();

    List<dynamic> groups = await userDocSnapshot.get('groups');

    if (groups.contains(groupId + '_' + groupName)) {
      return true;
    } else {
      return false;
    }
  }

  Future getUserData(String rollNo) async {
    QuerySnapshot snapshot =
        await userCollection.where('rollNo', isEqualTo: rollNo).get();

    print(snapshot.docs[0].data);
    return snapshot;
  }

  // Future<List<DocumentSnapshot>> getUserGroups() async {
  //   // ignore: await_only_futures
  //   var firestore = FirebaseFirestore.instance;
  //   QuerySnapshot qn = await firestore
  //       .collection('users')
  //       .doc(uid)
  //       .get();

  //   return qn.docs; 
  // }

  sendMessage(String groupId, chatMessageData) {
    FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .collection('messages')
        .add(chatMessageData);
    FirebaseFirestore.instance.collection('groups').doc(groupId).update({
      'recentMessage': chatMessageData()['message'],
      'recentMessageSender': chatMessageData()['sender'],
      'recentMessageTime': chatMessageData()['time'].toString(),
    });
  }

  getChats(String groupId) async {
    return FirebaseFirestore.instance
        .collection('groups')
        .doc(groupId)
        .collection('messages')
        .orderBy('time')
        .snapshots();
  }

  searchByName(String groupName) {
    return FirebaseFirestore.instance
        .collection('groups')
        .where('groupName', isEqualTo: groupName)
        .get();
  }
}
