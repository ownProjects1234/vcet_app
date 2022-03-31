//creating post,caption, location in firestore
import 'package:cloud_firestore/cloud_firestore.dart';

import '../create_post_firestore.dart';
import '../providers/get_user_info.dart';

final CollectionReference pPostsRef =
    FirebaseFirestore.instance.collection('pPosts');

createpPostInFirestore(
    String mediaUrl,String description, String postId) {
  pPostsRef.doc(postId).set({
    "profileUrl": currentUser?.photourl,
    "postId": postId,
    "userId": currentUser?.rollNo, //implement this later
    "email": currentUser?.email,
    "username": currentUser?.name, //implement this later
    "mediaUrl": mediaUrl,
    "description": description,
    //"location": location,
    "timestamp": timestamp, //implement this later
    "likes": {},
  });
}
