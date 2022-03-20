// ignore_for_file: file_names, camel_case_types
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class getQueries extends StatefulWidget {
  final String subj;

  const getQueries({Key? key, required this.subj}) : super(key: key);

  @override
  _getQueriesState createState() => _getQueriesState();
}

class _getQueriesState extends State<getQueries> {
  Widget displayQuery() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('query')
          .doc(widget.subj)
          .collection('queries')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.quickreply),
              title: Text(snapshot.data.docs[index].data()['query']),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.subj),),
      body: displayQuery(),
      
    );
  }
}
