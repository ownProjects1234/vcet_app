// ignore_for_file: file_names, camel_case_types
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vcet/colorClass.dart';
import 'package:vcet/frontend/others_profile.dart';

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
          .orderBy('time', descending: true)
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
            String rollNo =
                snapshot.data.docs[index].data()['rollNo'].toString();
            int timestamp = snapshot.data.docs[index].data()['time'];
            var format =  DateFormat("MMM dd kk:mm");
            DateTime date =
                DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);

            return Card(
              child: ListTile(
                leading: const Icon(Icons.production_quantity_limits_rounded,color: Colors.black54,),
                title: Text(snapshot.data.docs[index].data()['query'], style: TextStyle(letterSpacing: 0.8,fontSize: 17),),
                trailing: GestureDetector(
                  onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context)=> userProfile(userId: rollNo))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    Text(rollNo,style: TextStyle(fontSize: 13),),
                    Text(format.format(date), style: TextStyle(fontSize: 12))
                  ]),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myColors.secondaryColor,
        title: Text(widget.subj),
      ),
      body: displayQuery(),
    );
  }
}
