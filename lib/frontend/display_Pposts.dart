// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:vcet/backend/post/post_in_firestore.dart';
import 'package:vcet/colorClass.dart';

import '../backend/post/post_widget.dart';

class displayPosts extends StatefulWidget {
  const displayPosts({Key? key}) : super(key: key);

  @override
  State<displayPosts> createState() => _displayPostsState();
}

class _displayPostsState extends State<displayPosts> {
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          // backgroundColor: AppColor.secondarycolor,
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: myColors.buttonColor,
            centerTitle: true,
            leading: IconButton(
                onPressed: () => ZoomDrawer.of(context)!.toggle(),
                icon: Icon(Icons.menu)),
            title: const Text(
              "POSTS",
              style: TextStyle(letterSpacing: 2, fontWeight: FontWeight.bold),
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
      child: Container(
        padding: const EdgeInsets.only(bottom: 0),
        child: Column(
          children: posts,
        ),
      ),
    );
  }
}
