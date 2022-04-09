import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:image/image.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vcet/backend/API/downloadApi.dart';
import 'package:vcet/backend/counter.dart';
import 'package:vcet/backend/counterUpdate/query_count.dart';
import 'package:vcet/backend/create_post_firestore.dart';
import 'package:vcet/backend/firebase_file.dart';
import 'package:vcet/backend/providers/get_user_info.dart';
import 'package:vcet/backend/uploadfie.dart';
import 'package:vcet/chat/helper/helper_functions.dart';
import 'package:vcet/colorClass.dart';
import 'package:vcet/frontend/firstpage.dart';
import 'package:vcet/frontend/others_profile.dart';
import 'package:vcet/frontend/upload.dart';
import 'package:vcet/main.dart';

class notification extends StatefulWidget {
  final String fromWhere;
  final String subj;

//  final String img;
  const notification({Key? key, required this.subj, required this.fromWhere})
      : super(key: key);

  @override
  _notificationState createState() => _notificationState();
}

class _notificationState extends State<notification> {
  late Future<List<FirebaseFile>> futureFiles;
  String pic = '';
  String password = 'vcetstudentapp';
  final TextEditingController controllers = TextEditingController();
  String? uid;

  @override
  void initState() {
    super.initState();
    // pic = widget.img;
    futureFiles = DownloadApi.listAll(widget.subj + '/');
    getInfo();

    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification notification = message.notification!;
    //   AndroidNotification android = (message.notification?.android)!;
    //   if (notification != null && android != null) {
    //     flutterLocalNotificationsPlugin.show(
    //         notification.hashCode,
    //         notification.title,
    //         notification.body,
    //         NotificationDetails(
    //           android: AndroidNotificationDetails(
    //             channel.id,
    //             channel.name,
    //             // channel.description,
    //             color: Colors.blue,
    //             playSound: true,
    //             icon: '@mipmap/ic_launcher',
    //           ),
    //         ));
    //   }
    // });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification!;
      AndroidNotification android = (message.notification?.android)!;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
  }

  // void showNotification() {
  //   flutterLocalNotificationsPlugin.show(
  //       0,
  //       "Testing",
  //       "How you doing?",
  //       NotificationDetails(
  //           android: AndroidNotificationDetails(channel.id, channel.name,
  //               importance: Importance.high,
  //               color: Colors.blue,
  //               playSound: true,
  //               icon: '@mipmap/ic_launcher')));
  // }

  getInfo() async {
    HelperFunctions.getUserIdSharedPreference().then((value) {
      setState(() {
        uid = value;
      });
    });
  }

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
        if (datas['staff'] == 'false') {
          return Scaffold(
            backgroundColor: myColors.primaryColor,
            appBar: AppBar(
              backgroundColor: myColors.secondaryColor,
              title: const Text(
                "N O T I F I C A T I O N",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              leading: (widget.fromWhere == 'appBar')
                  ? IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios))
                  : IconButton(
                      onPressed: () => ZoomDrawer.of(context)!.toggle(),
                      icon: const Icon(Icons.menu)),
            ),
            body: StreamBuilder(
              stream: postsRef
                  //  .orderBy(timestamp, descending: true)
                  .where('subj', isEqualTo: widget.subj)
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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

                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        // reverse: true,
                        itemBuilder: (context, index) {
                          final data = snapshot.data!.docs[index];
                          String fileUrl = data['mediaUrl'];
                          String fileName = data['destination'];
                          String profileUrl = data['profileUrl'];
                          String userId = data['userId'];
                          String description = data['description'];
                          int time = data['timestamp'];
                          String name = data['userName'];

                          var format = new DateFormat("MMM dd kk:mm");
                          DateTime date =
                              DateTime.fromMicrosecondsSinceEpoch(time * 1000);

                          var splited = fileName.split('/');
                          String orgFileName = splited[1];

                          return Card(
                              elevation: 10.0,
                              margin: const EdgeInsets.all(10.0),

                              // shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(9.0)),
                              //color: Color(0xff081053),
                              color: Colors.white,
                              child: buildFile(
                                  context,
                                  fileUrl,
                                  orgFileName,
                                  profileUrl,
                                  userId,
                                  description,
                                  date,
                                  name,
                                  format));
                        },
                      );
                    }
                }
              },
            ),
            floatingActionButton: (widget.fromWhere == 'bottomNav')
                ? Padding(
                    padding: EdgeInsets.only(bottom: 70.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        openQuery("QUERY", 'Enter your query here');
                      },
                      child: const Icon(
                        Icons.add_box_outlined,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      backgroundColor: Colors.black87,
                      elevation: 0.0,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        openQuery("QUERY", 'Enter your query here');
                      },
                      child: const Icon(
                        Icons.add_box_outlined,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      backgroundColor: Colors.black87,
                      elevation: 0.0,
                    ),
                  ),
          );
        } else {
          return Scaffold(
            backgroundColor: myColors.primaryColor,
            appBar: AppBar(
              backgroundColor: myColors.secondaryColor,
              title: const Text(
                "N O T I F I C A T I O N",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              leading: IconButton(
                  onPressed: () => ZoomDrawer.of(context)!.toggle(),
                  icon: Icon(Icons.menu)),
            ),
            body: StreamBuilder(
              stream: postsRef
                  //  .orderBy(timestamp, descending: true)
                  .where('subj', isEqualTo: widget.subj)
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
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

                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        // reverse: true,
                        itemBuilder: (context, index) {
                          final data = snapshot.data!.docs[index];
                          String fileUrl = data['mediaUrl'];
                          String fileName = data['destination'];
                          String profileUrl = data['profileUrl'];
                          String userId = data['userId'];
                          String description = data['description'];
                          int time = data['timestamp'];
                          String name = data['userName'];

                          var format = new DateFormat("MMM dd kk:mm");
                          DateTime date =
                              DateTime.fromMicrosecondsSinceEpoch(time * 1000);

                          var splited = fileName.split('/');
                          String orgFileName = splited[1];

                          return Card(
                              elevation: 10.0,
                              margin: const EdgeInsets.all(10.0),

                              // shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(9.0)),
                              //color: Color(0xff081053),
                              color: Colors.white,
                              child: buildFile(
                                  context,
                                  fileUrl,
                                  orgFileName,
                                  profileUrl,
                                  userId,
                                  description,
                                  date,
                                  name,
                                  format));
                        },
                      );
                    }
                }
              },
            ),
            floatingActionButton: (widget.fromWhere == 'bottomNav')
                ? Padding(
                    padding: EdgeInsets.only(bottom: 70.0),
                    child: FloatingActionButton(
                      onPressed: () async {
                        //  showNotification();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UploadPage(
                                    pic: 'Notification', subj: widget.subj)));
                      },
                      child: const Icon(
                        Icons.upload_file,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      backgroundColor: Colors.black87,
                      elevation: 0.0,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: FloatingActionButton(
                      onPressed: () {
                        //   showNotification();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UploadPage(
                                    pic: 'Notification', subj: widget.subj)));
                      },
                      child: const Icon(
                        Icons.upload_file,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      backgroundColor: Colors.black87,
                      elevation: 0.0,
                    ),
                  ),
          );
        }
      },
    );
  }

//  child: Card(
//           color: Colors.cyan,
//           shape: RoundedRectangleBorder(
//             side: BorderSide(color: Colors.white70, width: 6),
//             borderRadius: BorderRadius.circular(20),
//           ),

//           elevation: 20,
//           // color: Colors.amber,
//           shadowColor: Colors.black54,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: CircleAvatar(
//                   radius: 30,
//                   backgroundColor: Colors.white,
//                   backgroundImage: NetworkImage(url),
//                 ),
//               ),
//               Center(
//                 child: Text(
//                   name,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 2,
//                   ),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.all(8),
//                 child: Icon(
//                   Icons.arrow_forward_ios_outlined,
//                   color: Colors.white,
//                 ),
//               )
//             ],
//           ),
//         ),

  Widget buildFile(
    BuildContext context,
    String fileUrl,
    String fileName,
    String profileUrl,
    String userId,
    String description,
    DateTime time,
    String userName,
    DateFormat format,
  ) =>
      Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(profileUrl),
                radius: 30 / 2,
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                  child: GestureDetector(
                onTap: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => userProfile(userId: userId)));
                }),
                child: Text(
                  userName,
                  maxLines: 1,
                  style: const TextStyle(color: Colors.black, fontSize: 15),
                ),
              )),
              const SizedBox(
                width: 5,
              ),
              Text('•',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
              const SizedBox(
                width: 5,
              ),
              Text(
                format.format(time),
                maxLines: 1,
                style: const TextStyle(color: Colors.black, fontSize: 12),
              ),
              const SizedBox(
                width: 5,
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              openFile(url: fileUrl, fileName: fileName);
            },
            child: Card(
              color: Colors.grey,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black, width: 3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(fileUrl), fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(20)),
                height: 220,
                width: 350,
                // child: const Center(
                //     child: Text(
                //   "PDF",
                //   style: TextStyle(
                //       color: Colors.black,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 24),
                // )),
                // child: Image.network(
                //   fileUrl,
                //   //height: 110.0,
                //   // width: double.infinity,
                //   fit: BoxFit.cover,
                // ),
              ),

              elevation: 20,
              // color: Colors.amber,
              shadowColor: Colors.black54,
            ),
          ),
          // ClipRect(
          //   child: SizedBox(
          //     height: 140,
          //     child: Image.network(
          //       fileUrl,
          //       height: 150.0,
          //       width: double.infinity,
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          // Container(
          //   decoration: BoxDecoration(
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.grey.withOpacity(0.5),
          //         spreadRadius: 5,
          //         blurRadius: 7,
          //         offset: const Offset(0, 3), // changes s of shadow
          //       ),
          //     ],
          //   ),
          // ),
          // const SizedBox(
          //   height: 8.0,
          // ),
          Text(
            description,
            style:
                TextStyle(color: Colors.black, letterSpacing: 1, fontSize: 16),
          ),

          // Container(
          //   decoration: BoxDecoration(
          //     boxShadow: [
          //       BoxShadow(
          //         color: Color.fromARGB(255, 250, 229, 229).withOpacity(1),
          //         spreadRadius: 0.5,
          //         blurRadius: 0.5,
          //         offset: const Offset(0, 4), // changes s of shadow
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // Row(
          //   children: [
          //     const SizedBox(
          //       width: 10,
          //     ),
          //     Flexible(
          //       child: Text(
          //         description,
          //         // maxLines: 1,
          //         // softWrap: false,
          //         // overflow: TextOverflow.ellipsis,
          //         textAlign: TextAlign.left,
          //         style: const TextStyle(
          //             fontSize: 16, color: Color.fromARGB(255, 39, 34, 34)),
          //       ),
          //     ),
          //     SizedBox(
          //       height: 10,
          //     ),
          //   ],
          // ),
          SizedBox(
            height: 5,
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
    updateQueryCount("Notification");
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


//  child: Card(
//           color: Colors.cyan,
//           shape: RoundedRectangleBorder(
//             side: BorderSide(color: Colors.white70, width: 6),
//             borderRadius: BorderRadius.circular(20),
//           ),

//           elevation: 20,
//           // color: Colors.amber,
//           shadowColor: Colors.black54,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: CircleAvatar(
//                   radius: 30,
//                   backgroundColor: Colors.white,
//                   backgroundImage: NetworkImage(url),
//                 ),
//               ),
//               Center(
//                 child: Text(
//                   name,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     letterSpacing: 2,
//                   ),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.all(8),
//                 child: Icon(
//                   Icons.arrow_forward_ios_outlined,
//                   color: Colors.white,
//                 ),
//               )
//             ],
//           ),
//         ),