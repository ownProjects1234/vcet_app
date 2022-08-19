import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:vcet/backend/Library/search_books.dart';
import 'package:vcet/colorClass.dart';
import 'package:vcet/frontend/library.dart';

import '../backend/Library/search_books.dart';

class listOfBooks extends StatefulWidget {
  final String subjName;
  const listOfBooks({Key? key, required this.subjName}) : super(key: key);

  @override
  State<listOfBooks> createState() => _listOfBooksState();
}

class _listOfBooksState extends State<listOfBooks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (context, isScrolled) {
        return <Widget>[
          SliverAppBar(
            backgroundColor: myColors.secondaryColor,
            floating: true,
            pinned: true,
            expandedHeight: 200,
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios)),

            // centerTitle: true,
            flexibleSpace: const FlexibleSpaceBar(
              centerTitle: true,
              background: Image(
                image: NetworkImage(
                    "https://images.unsplash.com/photo-1507842217343-583bb7270b66?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZnJlZSUyMGxpYnJhcnl8ZW58MHx8MHx8&w=1000&q=80"),
                fit: BoxFit.cover,
              ),
              collapseMode: CollapseMode.pin,
            ),
            title: const Text(
              "L I B R A R Y",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              searchBooks(subj: widget.subjName)));
                },
                icon: const Icon(Icons.search_rounded),
              )
            ],
          )
        ];
      },
      body: buildListOfBooks(),
    ));
  }

  Widget buildListOfBooks() {
    CollectionReference booksRef =
        libRef.doc(widget.subjName).collection('books');
    return StreamBuilder(
        stream: booksRef.orderBy('noOfBooks', descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    String topic = snapshot.data!.docs[index]['name'];
                    String author =
                        snapshot.data!.docs[index]['author'].toString();
                    String noOfBooks =
                        snapshot.data!.docs[index]['noOfBooks'].toString();
                    String rackNo =
                        snapshot.data!.docs[index]['rackNo'].toString();
                    String imageUrl =
                        snapshot.data!.docs[index]['imageUrl'].toString();
                    return SizedBox(
                      width: 100,
                      height: 100,
                      child: Card(
                          margin: const EdgeInsets.all(5),
                          borderOnForeground: true,
                          semanticContainer: true,
                          color: Color.fromARGB(255, 212, 99, 93),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 10,
                          // color: Colors.amber,
                          shadowColor: Colors.black,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //   SizedBox(width: 20,),
                              CircleAvatar(
                                radius: (50 / 3) + 2,
                                backgroundColor: myColors.buttonColor,
                                child: CircleAvatar(
                                    child: Container(
                                      decoration: BoxDecoration(),
                                    ),
                                    radius: 50 / 3,
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(imageUrl)),
                              ),

                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 200,
                                    child: Text(
                                      topic,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Text(
                                    author,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    'No of Books: $noOfBooks',
                                    style: const TextStyle(fontSize: 12),
                                  )
                                ],
                              ),

                              Text(
                                'Rack No: $rackNo',
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal),
                              )
                            ],
                          )),
                    );
                  })
              : Container();
        });
  }
}
