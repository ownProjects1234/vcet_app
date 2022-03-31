// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:vcet/backend/API/uploadApi.dart';
import 'package:vcet/backend/counter.dart';
import 'package:vcet/backend/create_post_firestore.dart';
import 'package:vcet/backend/displayfiles.dart';
import 'package:vcet/backend/profile_pic_to_storage.dart';
import 'package:vcet/backend/providers/get_user_info.dart';
import 'package:vcet/colorClass.dart';
import 'package:vcet/frontend/Appbar.dart';
import 'package:path/path.dart';
import 'package:vcet/frontend/firstpage.dart';
import 'package:vcet/frontend/notification.dart';
import 'package:vcet/frontend/snackbartext.dart';
import 'package:vcet/frontend/upload.dart';
import 'package:image/image.dart' as Im;
import 'package:vcet/main.dart';

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
    return file == null ? buildUploadfilepage() : buildUploadForm(context);
  }

  Future SelectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return;
    final path = result.files.single.path!;

    setState(() {
      file = File(path);
    });
  }

  String uniId = const Uuid().v4();

  //Clearing Image
  clearImage() {
    setState(() {
      file = null;
    });
  }

  bool isUploading = false;

  handleSubmit() async {
    setState(() {
      isUploading = true;
      counter1 = (counter1 ?? 0) + 1;
    });
    String mediaUrl = await UploadFile();
    print("post url is here $mediaUrl");

    createPostInFirestore(mediaUrl, captionController.text, destination!,
        fileName!, widget.subj, uniId);
    createCounter(counter1!);

    captionController.clear();
    setState(() {
      file = null;
      isUploading = false;
      uniId = const Uuid().v4();
    });
  }

  TextEditingController captionController = TextEditingController();

  //UploadForm with caption and location
  buildUploadForm(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo.shade50,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white70,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            clearImage();
          },
        ),
        title: const Text(
          'Upload Post',
          style: TextStyle(letterSpacing: 3, color: Colors.black),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: TextButton(
                onPressed: isUploading ? null : (() => handleSubmit()),
                child: const Text(
                  'Post',
                  style: TextStyle(
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )),
          )
        ],
      ),
      body: ListView(
        children: [
          isUploading ? const LinearProgressIndicator() : const Text(''),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Container(
              height: 220,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FileImage(file!), fit: BoxFit.cover)),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10.0),
          ),
          ListTile(
            leading:  CircleAvatar(
                // backgroundImage: AssetImage('images/I_image.jpg')
                backgroundImage: NetworkImage((currentUser?.photourl)!),
                ),
            title: Container(
                width: 250,
                child: TextField(
                    controller: captionController,
                    decoration: const InputDecoration(
                        hintText: "Write a caption...",
                        border: InputBorder.none))),
          ),
          const Divider(),
        ],
      ),
    );
  }

  buildUploadfilepage() {
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

  String? destination;
  String? fileName;

  Future<String> UploadFile() async {
    if (file == null) return '';

    fileName = basename(file!.path);
    destination = widget.subj + "/$fileName";

    task = UploadApi.uploadFile(destination!, file!);
    setState(() {});

    if (task == null) return '';

    final snapshot = await task!.whenComplete(() => {});
    String urlLink = await snapshot.ref.getDownloadURL();
    return urlLink;
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
