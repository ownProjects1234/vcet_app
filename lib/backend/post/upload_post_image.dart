//Uploading Image to Firebase Storage
import 'package:firebase_storage/firebase_storage.dart';


Reference storageReference = FirebaseStorage.instance.ref('Posts');

Future<String> uploadPImage(imageFile, postId) async {
  Reference ref = storageReference.child('post_$postId.jpg');
  UploadTask uploadTask = ref.putFile(imageFile);
  final snapshot = await uploadTask.whenComplete(() => {});
  final urlDownload = await snapshot.ref.getDownloadURL();
  print("The url is here! $urlDownload");
  return urlDownload;
}
