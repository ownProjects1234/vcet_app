// ignore_for_file: no_logic_in_create_state

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:vcet/backend/post/cached_image.dart';
import 'package:vcet/backend/post/post_in_firestore.dart';
import 'package:vcet/frontend/others_profile.dart';

import '../create_post_firestore.dart';
import '../providers/get_user_info.dart';

class Post extends StatefulWidget {
  final String description;
  final String email;
  final dynamic likes;
  // final String location;
  final String mediaUrl;
  final String postId;
  final int timestamp;
  final String userId;
  final String username;
  final String profileUrl;

  Post({
    required this.profileUrl,
    required this.description,
    required this.email,
    required this.likes,
    //   required this.location,
    required this.mediaUrl,
    required this.postId,
    required this.timestamp,
    required this.userId,
    required this.username,
  });

  factory Post.fromDocument(DocumentSnapshot doc) {
    return Post(
      profileUrl: doc['profileUrl'],
      description: doc['description'],
      email: doc['email'],
      likes: doc['likes'],
      // location: doc['location'],
      mediaUrl: doc['mediaUrl'],
      postId: doc['postId'],
      timestamp: doc['timestamp'],
      userId: doc['userId'],
      username: doc['username'],
    );
  }

  int getLikeCount(likes) {
    if (likes == null) {
      return 0;
    }
    int count = 0;
    likes.values.forEach((val) {
      if (val == true) {
        count += 1;
      }
    });
    return count;
  }

  @override
  _PostState createState() => _PostState(
      profileUrl: profileUrl,
      description: description,
      email: email,
      likes: likes,
      //  location: location,
      mediaUrl: mediaUrl,
      postId: postId,
      timestamp: timestamp,
      userId: userId,
      username: username,
      likeCount: getLikeCount(likes));
}

class _PostState extends State<Post> {
  bool? isLiked;
  final String? currentUserId = currentUser?.rollNo;
  final String description;
  final String email;
  Map likes;
//  final String location;
  final String mediaUrl;
  final String postId;
  final int timestamp;
  final String userId;
  final String username;
  int likeCount;
  final String profileUrl;

  _PostState({
    required this.profileUrl,
    required this.likeCount,
    required this.description,
    required this.email,
    required this.likes,
    //   required this.location,
    required this.mediaUrl,
    required this.postId,
    required this.timestamp,
    required this.userId,
    required this.username,
  });

//Top in the post
  buildPostHeader(time) {
    return ListTile(
      focusColor: Colors.indigo.shade50,
      leading: CircleAvatar(
        backgroundImage: profileUrl != null
            ? NetworkImage(profileUrl)
            : const NetworkImage(
                'https://www.kindpng.com/picc/m/21-214439_free-high-quality-person-icon-default-profile-picture.png'),
        backgroundColor: Colors.grey,
      ),
      title: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => userProfile(userId: userId))),
        child: Row(
          children: [
            Text(
              username + " • " + "$time",
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
      //   subtitle: Text(location),
      // trailing: IconButton(
      //   onPressed: () {},
      //   icon: Icon(Icons.more_vert),
      // ),
    );
  }

//Displaying image
  buildPostImage() {
    return GestureDetector(
      onDoubleTap: (() => handleLikePost()),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              height: 400,
              width: MediaQuery.of(context).size.width,
              child: cachedNetworkImage(mediaUrl)),
        ],
      ),
    );
  }

  buildPostFooter(time) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     Container(
        //       margin: EdgeInsets.only(left: 20),
        //       child: Text(
        //         "$time",
        //         style: const TextStyle(
        //             color: Colors.black, fontWeight: FontWeight.bold),
        //       ),
        //     )
        //   ],
        // ),
        // SizedBox(
        //   height: 5,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 40, left: 20),
            ),
            GestureDetector(
              onTap: (() => handleLikePost()),
              child: Icon(
                isLiked! ? Icons.favorite : Icons.favorite_border_sharp,
                size: 28.0,
                color: Colors.pink,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 40, left: 20),
            ),
            Text(
              "$likeCount likes",
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            )
          ],
        ),
        // SizedBox(
        //   height: 5,
        // ),
        // // Row(
        //   children: [
        //     Container(
        //       margin: EdgeInsets.only(left: 20),
        //       child: Text(
        //         "$likeCount likes",
        //         style: const TextStyle(
        //             color: Colors.black, fontWeight: FontWeight.bold),
        //       ),
        //     )
        //   ],
        // ),
        // const SizedBox(
        //   height: 6,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                description,
                style: const TextStyle(letterSpacing: 1),
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(
            bottom: 0,
          ),
        ),
      ],
    );
  }

  handleLikePost() {
    bool _isLiked = likes[currentUserId] == true;

    if (_isLiked) {
      pPostsRef.doc(postId).update({'likes.$currentUserId': false});
      setState(() {
        likeCount -= 1;
        isLiked = false;
        likes[currentUserId] = false;
      });
    } else if (!_isLiked) {
      pPostsRef.doc(postId).update({'likes.$currentUserId': true});
      setState(() {
        likeCount += 1;
        isLiked = true;
        likes[currentUserId] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    isLiked = (likes[currentUserId] == true);

    var format = new DateFormat("MMM dd kk:mm");
    DateTime date = DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);

    //  DateTime nowTime = DateTime.parse(timestamp.toDate().toString());
    String time = format.format(date);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildPostHeader(time),
        buildPostImage(),
        buildPostFooter(time)
      ],
    );
  }
}
