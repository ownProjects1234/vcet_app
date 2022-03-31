import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vcet/colorClass.dart';
import 'package:vcet/frontend/profile.dart';

class userProfile extends StatelessWidget {
  final String userId;
  const userProfile({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? name;
    String? email;
    String? about;
    String? profileUrl;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var datas = snapshot.data;

        name = datas['name'];
        email = datas['email'];
        about = datas['major'];
        profileUrl = datas['photourl'];
        return Scaffold(
          backgroundColor: myColors.secondaryColor,
          extendBody: true,
          appBar: AppBar(
            elevation: 0.0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
            title: Text(
              name!,
              style: const TextStyle(
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back),
            ),
          ),
          body: Container(
              padding: EdgeInsets.only(top: 30),
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(60.0),
                          topRight: Radius.circular(60.0))),
                  height: 700,
                  width: double.infinity,
                  padding:
                      EdgeInsets.only(left: 15, top: 20, right: 15, bottom: 10),
                  child: ListView(children: [
                    Center(child: buildprofileimage(profileUrl!)),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "NAME:",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(padding: EdgeInsets.only(left: 15)),
                        const Icon(
                          Icons.person_rounded,
                          color: Colors.black,
                        ),
                        const Padding(padding: EdgeInsets.only(left: 25)),
                        Text(
                          name!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 17),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "EMAIL:",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(padding: EdgeInsets.only(left: 15)),
                        const Icon(Icons.email, color: Colors.black),
                        const Padding(padding: EdgeInsets.only(left: 25)),
                        Text(
                          email!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 17),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    (datas['staff'] == 'false')
                        ? const Text(
                            "ROLL NO:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          )
                        : const Text(
                            "USER ID:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                      height: 20,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(padding: EdgeInsets.only(left: 15)),
                        const Icon(Icons.code_sharp, color: Colors.black),
                        const Padding(padding: EdgeInsets.only(left: 25)),
                        Text(
                          userId,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: 17),
                        ),
                        // IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    (datas['staff'] == 'false')
                        ? const Text(
                            "ABOUT US:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          )
                        : const Text(
                            "MAJOR FIELD:",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        about!,
                        maxLines: 5,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            fontSize: 17),
                      ),
                    ),
                  ]),
                ),
              )),
        );
      },
    );
  }

  Widget buildprofileimage(String profileUrl) {
    return CircleAvatar(
      radius: (144 / 2) + 5,
      backgroundColor: Colors.black,
      child: CircleAvatar(
        child: Container(
          decoration: BoxDecoration(),
        ),
        radius: 144 / 2,
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(profileUrl),
      ),
    );
  }
}
