import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vcet/backend/API/uploadApi.dart';
import 'package:vcet/backend/displayfiles.dart';
import 'package:vcet/colorClass.dart';
import 'package:vcet/frontend/Appbar.dart';
import 'package:path/path.dart';
import 'package:vcet/frontend/snackbartext.dart';

class UploadPage extends StatefulWidget {
  final String subj;
  final String pic;

  const UploadPage({Key? key, required this.pic, required this.subj})
      : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  UploadTask? task;
  File? file;

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? basename(file!.path) : "No file Selected";

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
                  image: AssetImage('images/project/' + widget.pic + '.jpg'),
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
        body: Container(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ElevatedButton(
                //     onPressed: SelectFile, child: const Text("Select File")),

                // ElevatedButton(
                //    onPressed: SelectFile, child: const Text("Select File")),
                OutlinedButton(
                  onPressed: SelectFile,
                  child: const Text(
                    "Select File",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.black),
                  ),
                  style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 60),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),

                const SizedBox(
                  height: 8,
                ),
                Text(
                  fileName,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 48,
                ),
                // ElevatedButton(
                //     onPressed: UploadFile, child: const Text("Upload File")),
                //   ElevatedButton(
                //   onPressed: UploadFile, child: const Text("Upload File")),
                ElevatedButton(
                  onPressed: UploadFile,
                  child: const Text(
                    "Upload File",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        letterSpacing: 2,
                        color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 255, 136, 34),
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),

                const SizedBox(
                  height: 20,
                ),
                task != null ? buildUploadStatus(task!) : Container(),
                const SizedBox(
                  height: 20,
                ),
                // ElevatedButton(
                //     onPressed: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => const displayPage()),
                //       );
                //     },
                //     child: const Text("Display files"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future SelectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return;
    final path = result.files.single.path!;

    setState(() {
      file = File(path);
    });
  }

  Future UploadFile() async {
   

    if (file == null) return;

    final fileName = basename(file!.path);
    final destination = widget.subj + "/$fileName";

    task = UploadApi.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() => {});
    final urlDownload = await snapshot.ref.getDownloadURL();
  }

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
      stream: task.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final snap = snapshot.data!;
          final progress = snap.bytesTransferred / snap.totalBytes;
          final percentage = (progress * 100).toString();

          return Text(
            // ignore: unnecessary_string_interpolations
            "$percentage%",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          );
        } else {
          return Container();
        }
      });
}
