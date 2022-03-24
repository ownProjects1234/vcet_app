import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final Reference storageReference = FirebaseStorage.instance.ref();

Future<String> uploadImage(imageFile, postId) async {
  Reference ref = storageReference.child('profile_$postId.jpg');
  UploadTask uploadTask = ref.putFile(imageFile);
  final snapshot = await uploadTask.whenComplete(() => {});
  final urlDownload = await snapshot.ref.getDownloadURL();
  print("The url is here! $urlDownload");
  return urlDownload;
}
