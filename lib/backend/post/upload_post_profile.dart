import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:uuid/uuid.dart';
import 'package:image/image.dart' as Im;

import 'package:vcet/backend/post/post_in_firestore.dart';
import 'package:vcet/backend/post/post_widget.dart';
import 'package:vcet/backend/post/update_post_count.dart';
import 'package:vcet/backend/post/upload_post_image.dart';
import 'package:vcet/chat/pages/profile_page.dart';
import 'package:vcet/colorClass.dart';
import 'package:vcet/frontend/profile.dart';

import '../profile_pic_to_storage.dart';
import '../providers/get_user_info.dart';

class uploadPostFromProfile extends StatefulWidget {
  const uploadPostFromProfile({Key? key}) : super(key: key);

  @override
  State<uploadPostFromProfile> createState() => _uploadPostFromProfileState();
}

class _uploadPostFromProfileState extends State<uploadPostFromProfile> {
  TextEditingController locationController = TextEditingController();
  TextEditingController captionController = TextEditingController();

  File? file;
  bool isUploading = false;
  String postId = const Uuid().v4();
  String profile = currentUser?.photourl ??
      "https://www.kindpng.com/picc/m/21-214439_free-high-quality-person-icon-default-profile-picture.png";

  bool _isLoading = false;
  List<Post> posts = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfilePosts();
  }

  getProfilePosts() async {
    setState(() {
      _isLoading = true;
    });

    QuerySnapshot snapshot =
        await pPostsRef.orderBy('timestamp', descending: true).get();
    setState(() {
      _isLoading = false;
      posts = snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
    });
  }

//Taking photo from camera
  handleTakePhoto() async {
    Navigator.pop(context);

    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      //print(image);

      final imageTemporary = File(image.path);
      setState(() {
        this.file = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  //Picking image from gallery
  handleChoosePhoto() async {
    Navigator.pop(context);

    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      //print(image);

      final imageTemporary = File(image.path);
      setState(() {
        this.file = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  selectImage(parentContext) {
    showDialog(
        context: parentContext,
        builder: ((context) {
          return SimpleDialog(
            title: const Text("Create Post"),
            children: [
              SimpleDialogOption(
                child: const Text('Photo with Camera'),
                onPressed: () {
                  handleTakePhoto();
                },
              ),
              SimpleDialogOption(
                child: const Text('Image from Gallery'),
                onPressed: () {
                  handleChoosePhoto();
                },
              ),
              SimpleDialogOption(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        }));
  }

  buildSplashScreen() {
    return Container(
      color: Colors.white,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Image(
          image: AssetImage(
            'images/10.jpg',
          ),
          height: 260,
        ),
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: MaterialButton(
            onPressed: () {
              selectImage(context);
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              "Upload Post",
              style: TextStyle(color: Colors.white, fontSize: 22.0),
            ),
            color: myColors.secondaryColor,
          ),
        ),
      ]),
    );
  }

//Displaying Post in Column
  buildProfilePosts() {
    if (_isLoading) {
      return CircularProgressIndicator();
    }
    return SingleChildScrollView(
      child: Column(
        children: posts,
      ),
    );
  }

  //Clearing Image
  clearImage() {
    setState(() {
      file = null;
    });
  }

  //Submitting the post
  handleSubmit() async {
    setState(() {
      isUploading = true;
    });

    String mediaUrl = await uploadPImage(file, postId);
    print(mediaUrl);
    createpPostInFirestore(mediaUrl, captionController.text, postId);
    updatePostCount();
    captionController.clear();
    locationController.clear();
    setState(() {
      file = null;
      isUploading = false;
      postId = const Uuid().v4();
    });
  }

  //UploadForm with caption and location
  buildUploadForm() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            clearImage();
          },
        ),
        title: const Text(
          'Caption Post',
          style: TextStyle(color: Colors.blue),
        ),
        actions: [
          MaterialButton(
            onPressed: isUploading ? null : (() => handleSubmit()),
            child: const Text(
              "Post",
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          isUploading ? const LinearProgressIndicator() : const Text(''),
          Container(
            height: 220,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
                child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(image: FileImage(file!))),
              ),
            )),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
          ),
          ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage(profile)),
            title: Container(
                width: 250,
                child: TextField(
                    controller: captionController,
                    decoration: const InputDecoration(
                        hintText: "Write a description...",
                        border: InputBorder.none))),
          ),
          const Divider(),
        ],
      ),
    );
  }
  goToProfile(){
    
  }

  @override
  Widget build(BuildContext context) {
    return file == null ? buildSplashScreen() : buildUploadForm();
  }
}
