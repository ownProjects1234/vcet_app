import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vcet/backend/API/downloadApi.dart';
import 'package:vcet/backend/firebase_file.dart';
import 'package:vcet/backend/uploadfie.dart';
import 'package:vcet/colorClass.dart';

class notification extends StatefulWidget {
  final String subj;
//  final String img;
  const notification({Key? key, required this.subj}) : super(key: key);

  @override
  _notificationState createState() => _notificationState();
}

class _notificationState extends State<notification> {
  late Future<List<FirebaseFile>> futureFiles;
  String pic = '';
  String password = 'vcetstudentapp';
  final TextEditingController controllers = TextEditingController();

  @override
  void initState() {
    super.initState();
    // pic = widget.img;
    futureFiles = DownloadApi.listAll(widget.subj + '/');
  }

  // @override
  // void initState() {
  //   futureFiles = DownloadApi.listAll(widget.subj + '/');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myColors.primaryColor,
      appBar: AppBar(
        backgroundColor: myColors.secondaryColor,
        title: Text(
          'N O T I F I C A T I O N',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => ZoomDrawer.of(context)!.toggle(),
            icon: Icon(Icons.menu)),
      ),
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
                return (const Center(child: Text('Some error occurred!')));
              } else {
                final files = snapshot.data!;

                return ListView.builder(
                  itemCount: files.length,
                  itemBuilder: (context, index) {
                    final file = files[index];

                    return GestureDetector(
                      onTap: () => openFile(url: file.url, fileName: file.name),
                      child: Card(
                          elevation: 10.0,
                          margin: const EdgeInsets.all(8.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          color: Colors.blue[400],
                          child: buildFile(context, file)),
                    );
                  },
                );
              }
          }
        },
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 70.0),
        child: FloatingActionButton(
          onPressed: () {
            openDialog('Enter Password', 'password');
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

  Widget buildFile(BuildContext context, FirebaseFile file) => Column(
        children: [
          ClipRect(
            child: SizedBox(
              height: 140,
              child: Image.network(
                file.url,
                height: 110.0,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
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
          SizedBox(
            height: 8,
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
                  UploadPage(pic: 'Notification', subj: widget.subj)));
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
}
