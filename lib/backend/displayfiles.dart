// ignore_for_file: camel_case_types

import 'dart:developer';

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vcet/backend/API/downloadApi.dart';
import 'package:vcet/backend/counter.dart';
import 'package:vcet/backend/counterUpdate/query_count.dart';
import 'package:vcet/backend/create_post_firestore.dart';
import 'package:vcet/backend/firebase_file.dart';
import 'package:vcet/backend/providers/get_user_info.dart';
import 'package:vcet/backend/uploadfie.dart';
import 'package:vcet/chat/helper/helper_functions.dart';
import 'package:vcet/chat/services/database_service.dart';
import 'package:vcet/colorClass.dart';
import 'package:vcet/frontend/Appbar.dart';
import 'package:vcet/frontend/firstpage.dart';
import 'package:vcet/frontend/upload.dart';

class displayPage extends StatefulWidget {
  final String subj;
  final String img;
  displayPage({Key? key, required this.subj, required this.img})
      : super(key: key);

  @override
  _displayPageState createState() => _displayPageState();
}

class _displayPageState extends State<displayPage> {
  String? uid;

  String? isStaffs;
  @override
  void initState() {
    super.initState();
    getInfo();

    //isStaff(uid);

    pic = widget.img;
    futureFiles = DownloadApi.listAll(widget.subj + '/');
  }

  getInfo() async {
    HelperFunctions.getUserIdSharedPreference().then((value) {
      setState(() {
        uid = value;
      });
    });
  }

  late Future<List<FirebaseFile>> futureFiles;
  String pic = '';
  String password = 'vcetstudentapp';
  final TextEditingController controllers = TextEditingController();

  // @override
  // void initState() {
  //   futureFiles = DownloadApi.listAll(widget.subj + '/');
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection('users').doc(uid).snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        var datas = snapshot.data;

        isStaffs = (datas['staff']).toString();
        if (datas['staff'] == 'false') {
          return Scaffold(
            backgroundColor: myColors.primaryColor,
            body: NestedScrollView(
              headerSliverBuilder: (context, isScrolled) {
                return <Widget>[
                  SliverAppBar(
                    backgroundColor: myColors.secondaryColor,
                    floating: true,
                    pinned: true,
                    expandedHeight: 200,

                    // centerTitle: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      background: Image(
                        image:
                            AssetImage('images/project/' + widget.img + '.jpg'),
                        fit: BoxFit.cover,
                      ),
                      collapseMode: CollapseMode.pin,
                    ),
                    title: Text(
                      widget.subj,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ];
              },
              body: FutureBuilder<List<FirebaseFile>>(
                future: futureFiles,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      if (snapshot.hasError) {
                        return (const Center(
                            child: Text('Some error occurred!')));
                      } else {
                        final files = snapshot.data!;

                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemCount: files.length,
                          itemBuilder: (context, index) {
                            final file = files[index];

                            return GestureDetector(
                              onTap: () =>
                                  openFile(url: file.url, fileName: file.name),
                              child: Card(
                                  elevation: 10.0,
                                  margin: const EdgeInsets.all(8.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  color: Colors.blue[400],
                                  child: buildFile(context, file)),
                            );
                          },
                        );
                      }
                  }
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // openDialog('Enter Password', 'password');
                openQuery('QUERY', 'Enter your query here');
              },
              child: const Icon(
                Icons.add_box_outlined,
                color: Colors.white,
                size: 30.0,
              ),
              backgroundColor: Colors.black87,
              elevation: 0.0,
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: myColors.primaryColor,
            body: NestedScrollView(
              headerSliverBuilder: (context, isScrolled) {
                return <Widget>[
                  SliverAppBar(
                    backgroundColor: myColors.secondaryColor,
                    floating: true,
                    pinned: true,
                    expandedHeight: 200,

                    // centerTitle: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      background: Image(
                        image:
                            AssetImage('images/project/' + widget.img + '.jpg'),
                        fit: BoxFit.cover,
                      ),
                      collapseMode: CollapseMode.pin,
                    ),
                    title: Text(
                      widget.subj,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ];
              },
              body: FutureBuilder<List<FirebaseFile>>(
                future: futureFiles,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      if (snapshot.hasError) {
                        return (const Center(
                            child: Text('Some error occurred!')));
                      } else {
                        final files = snapshot.data!;

                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemCount: files.length,
                          itemBuilder: (context, index) {
                            final file = files[index];

                            return GestureDetector(
                              onTap: () =>
                                  openFile(url: file.url, fileName: file.name),
                              child: Card(
                                  elevation: 10.0,
                                  margin: const EdgeInsets.all(8.0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  color: Colors.blue[400],
                                  child: buildFile(context, file)),
                            );
                          },
                        );
                      }
                  }
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // openDialog('Enter Password', 'password');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UploadPage(
                              pic: widget.img,
                              subj: widget.subj,
                            )));
              },
              child: const Icon(
                Icons.upload_file,
                color: Colors.white,
                size: 30.0,
              ),
              backgroundColor: Colors.black87,
              elevation: 0.0,
            ),
          );
        }
      },
    );
  }

  Widget buildFile(BuildContext context, FirebaseFile file) => Column(
        children: [
          Image.asset(
            "images/pdfImage.jpg",
            height: 80.0,
            width: 120.0,
            fit: BoxFit.fill,
          ),
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Center(
            child: Text(
              file.name,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 8.0,
          )
        ],
      );

  Future openFile({required String url, String? fileName}) async {
    final file = await downloadFile(url, fileName!);
    if (file == null) return;
    print('Path: ${file.path}');

    OpenFile.open(file.path);
  }

  Future<File?> downloadFile(String url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');
    try {
      final response = await Dio().get(url,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveTimeout: 0));

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      return file;
    } catch (e) {
      return null;
    }
  }

  Future<String?> openDialog(fieldname, hintname) => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(fieldname),
            content: TextField(
              controller: controllers,
              autofocus: true,
              decoration: InputDecoration(hintText: hintname),
            ),
            actions: [TextButton(onPressed: submit, child: Text("SUBMIT"))],
          ));
  void submit() {
    if (controllers.text == password) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  UploadPage(pic: widget.img, subj: widget.subj)));
    } else {
      Future(() {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text(
                  "Wrong Password",
                  style: TextStyle(color: Colors.red),
                ),
              );
            });
      });
    }
  }

  Future<String?> openQuery(fieldname, hintname) => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(fieldname),
            content: TextField(
              controller: controllers,
              autofocus: true,
              decoration: InputDecoration(hintText: hintname),
            ),
            actions: [TextButton(onPressed: submitonFb, child: Text("SUBMIT"))],
          ));
  submitonFb() {
    counter1 = counter1 ?? 0 + 1;
    createQueries(controllers.text, widget.subj);
    updateQueryCount(widget.subj);
    Navigator.pop(context);
    Future(() {
      AlertDialog(
        content: Text(
          "Query sent successfully!",
          style: TextStyle(color: Colors.green[300]),
        ),
      );
    });
  }

  createQueries(String query, String subj) async {
    FirebaseFirestore.instance
        .collection('query')
        .doc(subj)
        .collection('queries')
        .add({
      "query": query,
      "subj": subj,
      "time": timestamp,
      "rollNo": currentUser?.rollNo
    });
  }
}
