import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:vcet/backend/Library/queryData.dart';
import 'package:vcet/colorClass.dart';

class searchBooks extends StatefulWidget {
  final String subj;
  const searchBooks({Key? key, required this.subj}) : super(key: key);

  @override
  State<searchBooks> createState() => _searchBooksState();
}

class _searchBooksState extends State<searchBooks> {
  final TextEditingController searchController = TextEditingController();
  QuerySnapshot? snapshotdata;
  bool isExecuted = false;

  @override
  Widget build(BuildContext context) {
    Widget searchedData() {
      return ListView.builder(
          itemCount: snapshotdata!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            String topic = snapshotdata!.docs[index]['name'].toString();
            String author = snapshotdata!.docs[index]['author'].toString();
            String noOfBooks =
                snapshotdata!.docs[index]['noOfBooks'].toString();
            String rackNo = snapshotdata!.docs[index]['rackNo'].toString();
            String imageUrl = snapshotdata!.docs[index]['imageUrl'].toString();

            return SizedBox(
              // width: 100,
              height: 140,
              child: Card(
                  // margin: const EdgeInsets.all(5),
                  borderOnForeground: true,
                  semanticContainer: true,
                  color: Color.fromARGB(255, 0, 8, 165),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white, width: 4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10,
                  shadowColor: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 100,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(imageUrl))),
                        ),
                        Container(
                          width: 260,
                          // color: Colors.red,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    topic,
                                    // overflow: TextOverflow.ellipsis,
                                    //maxLines: 1,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Author: $author',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Total No of Books: $noOfBooks',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                              const Expanded(
                                child: Text(
                                  'Books Available: 2',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  'Rack No: $rackNo',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal),
                                ),
                              )
                            ],
                          ),
                        ),
                        // Text(
                        //   'Rack No: $rackNo',
                        //   style: const TextStyle(fontWeight: FontWeight.normal),
                        // )
                      ],
                    ),
                  )),
            );
          });
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.clear),
          onPressed: () {
            setState(() {
              searchController.clear();
            });
          }),
      appBar: AppBar(
        actions: [
          GetBuilder<DataController>(
              init: DataController(),
              builder: (val) {
                return IconButton(
                    onPressed: () {
                      val
                          .queryData(searchController.text, widget.subj)
                          .then((value) {
                        snapshotdata = value;
                        print(snapshotdata);
                        setState(() {
                          isExecuted = true;
                        });
                      });
                    },
                    icon: Icon(Icons.search));
              })
        ],
        title: TextField(
          onChanged: ((value) {
            DataController().queryData(value, widget.subj).then((snap) {
              snapshotdata = snap;
              setState(() {
                isExecuted = true;
              });
            });
          }),
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
              hintText: "Search Books",
              hintStyle: TextStyle(color: Colors.white)),
          controller: searchController,
        ),
      ),
      body: isExecuted
          ? searchedData()
          : Container(
              child: const Center(
                  child: Text(
                "Search any book",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
            ),
    );
  }
}
