// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:vcet/chat/helper/helper_functions.dart';
import 'package:vcet/chat/services/database_service.dart';
import 'package:vcet/colorClass.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:vcet/frontend/getQueries.dart';

class queryPage extends StatefulWidget {
  const queryPage({Key? key}) : super(key: key);

  @override
  State<queryPage> createState() => _queryPageState();
}

class _queryPageState extends State<queryPage> {
  String? uid;
  Stream<QuerySnapshot>? users;
  int length = 0;

  List<String> totalSubj = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInfo();
    getData();
    print(totalSubj);
  }

  Widget getData() {
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        var userDoc = snapshot.data;
        totalSubj = List.from(userDoc['subj']);
        length = totalSubj.length;
        return ListView.builder(
          itemCount: length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Card(
                margin: const EdgeInsets.all(5),
                borderOnForeground: true,
                semanticContainer: true,
                color: Colors.cyan.shade500,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.white70, width: 5),
                  borderRadius: BorderRadius.circular(20),
                ),

                elevation: 10,
                // color: Colors.amber,
                shadowColor: Colors.black,
                child: ListTile(
                  leading: const Icon(
                    Icons.question_answer,
                    color: Colors.white,
                  ),
                  title: Text(
                    totalSubj[index],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, letterSpacing: 2),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => getQueries(
                              subj: totalSubj[index].toString(),
                            )));
              },
            );
          },
        );
      },
    );
  }

  getInfo() async {
    HelperFunctions.getUserIdSharedPreference().then((value) {
      setState(() {
        uid = value;
      });
      print(uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      appBar: AppBar(
        title: const Text(
          "QUERIES",
          style: TextStyle(letterSpacing: 3, fontWeight: FontWeight.bold),
        ),
        backgroundColor: myColors.secondaryColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: getData(),
      ),
    );
  }
}
