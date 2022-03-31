import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:vcet/backend/post/post_widget.dart';
import 'package:vcet/backend/providers/get_user_info.dart';
import 'package:vcet/colorClass.dart';

import '../backend/post/post_in_firestore.dart';

class displayPostsFromProfile extends StatefulWidget {
  const displayPostsFromProfile({Key? key}) : super(key: key);

  @override
  State<displayPostsFromProfile> createState() =>
      _displayPostsFromProfileState();
}

class _displayPostsFromProfileState extends State<displayPostsFromProfile> {
  bool _isLoading = false;
  List<Post> posts = [];
  String rollNo = (currentUser?.rollNo)!;

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

    QuerySnapshot snapshot = await pPostsRef
        .where('userId', isEqualTo: rollNo)
        .orderBy('timestamp', descending: true)
        .get();
    setState(() {
      _isLoading = false;
      posts = snapshot.docs.map((doc) => Post.fromDocument(doc)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: myColors.secondaryColor,
            centerTitle: true,
            leading: IconButton(
                onPressed: () => ZoomDrawer.of(context)!.toggle(),
                icon: Icon(Icons.menu)),
            title: const Text(
              "POST & ARTICLE",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          body: buildProfilePosts()),
    );
  }

  buildProfilePosts() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return SingleChildScrollView(
      child: Column(
        children: posts,
      ),
    );
  }
}
