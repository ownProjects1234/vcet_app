import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vcet/backend/uploadApi.dart';
import 'package:vcet/frontend/Appbar.dart';
import 'package:path/path.dart';
import 'package:vcet/frontend/snackbartext.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

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
      appBar: Appbars("Upload"),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: SelectFile, child: const Text("Select File")),
              const SizedBox(
                height: 8,
              ),
              Text(
                fileName,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 48,
              ),
              ElevatedButton(
                  onPressed: UploadFile, child: const Text("Upload File")),
              const SizedBox(
                height: 20,
              ),
              task != null ? buildUploadStatus(task!) : Container()
            ],
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
    final destination = "BEIE/$fileName";

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
          if (percentage == 100.0) {
           const snackbar();
          }
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
