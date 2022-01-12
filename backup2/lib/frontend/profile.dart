import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:image_picker/image_picker.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  final _controller = TextEditingController();
  String names = "VCET";
  File? image;
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

   TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          centerTitle: true,
          leading: IconButton(
              onPressed: () => ZoomDrawer.of(context)!.toggle(),
              icon: Icon(Icons.menu)),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 15, top: 20, right: 15),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              border: Border.all(width: 4, color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1))
                              ],
                              shape: BoxShape.circle,
                              image: DecorationImage(image: img().image))),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 1, color: Colors.black),
                                color: Colors.teal),
                            child: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: ((builder) => bottomSheet()));
                                },
                                icon: Icon(Icons.add_a_photo)),
                            // color: Colors.white,
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "NAME:",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 15)),
                    const Icon(Icons.person_rounded),
                    const Padding(padding: EdgeInsets.only(left: 25)),
                    Text(
                      names,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 17),
                    ),
                    Padding(padding: EdgeInsets.only(left: 200)),
                    IconButton(
                        onPressed: () {
                          openDialog();
                        },
                        icon: Icon(Icons.edit)),
                  ],
                ),
                const Text(
                  "EMAIL:",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 15)),
                    const Icon(Icons.email),
                    const Padding(padding: EdgeInsets.only(left: 25)),
                    Text(
                      names,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 17),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 200)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                  ],
                ),
                const Text(
                  "ROLL NO:",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 15)),
                    const Icon(Icons.code_sharp),
                    const Padding(padding: EdgeInsets.only(left: 25)),
                    Text(
                      names,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 17),
                    ),
                    const Padding(padding: EdgeInsets.only(left: 200)),
                    // IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    const Text(
                      "ABOUT ME",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Padding(padding: EdgeInsets.only(left: 230)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                  ],
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Padding(padding: EdgeInsets.only(left: 60)),

                    // const Padding(padding: EdgeInsets.only(left: 25)),
                    Text(
                      "Write about yourself",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 17),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("ENTER YOUR NAME"),
            content:  TextField(
              controller: textController,
              decoration: InputDecoration(hintText: "Enter your name"),
            ),
            actions: [TextButton(onPressed: submit, child: Text("SUBMIT"))],
          ));
  void submit() {
    Navigator.of(context).pop();
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const Text(
            "Choose profile photo",
            style: TextStyle(fontSize: 20.0),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () => pickImage(ImageSource.camera),
                  icon: Icon(Icons.camera)),
              const Text(
                "Camera",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () => pickImage(ImageSource.gallery),
                  icon: Icon(Icons.image)),
              const Text(
                "Gallery",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }

  Image img() {
    if (image == null) {
      return Image.asset("images/logo1.webp");
    } else {
      return Image.file(image!);
    }
  }
}
