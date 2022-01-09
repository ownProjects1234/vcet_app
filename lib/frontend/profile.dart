import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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
                              image: 
                             
                              )),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(width: 4, color: Colors.black),
                                color: Colors.teal),
                            child: IconButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: ((builder) => bottomSheet()));
                                },
                                icon: Icon(Icons.edit)),
                            // color: Colors.white,
                          ))
                    ],
                  ),
                ),
               const  SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    names,
                    style:const  TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.cyan,
                        fontSize: 15),
                  ),
                ),
               const  SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                      hintText: "Enter User Name",
                      hintStyle: TextStyle(color: Colors.black),
                      labelText: "USERNAME",
                      labelStyle: TextStyle(color: Colors.black),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text(
                        "CANCEL",
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.black),
                      ),
                      style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          names = _controller.text;
                        });
                      },
                      child: const Text(
                        "SAVE",
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 2,
                            color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ],
                ),
                image != null
                    ? Image.file(
                        image!,
                        width: 160,
                        height: 160,
                        fit: BoxFit.cover,
                      )
                    : FlutterLogo(
                        size: 160,
                      )
              ],
            ),
          ),
        ));
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

  Image img(){
    return image == null ? const AssetImage("images/logo1.webp") : Image.file(File());
  }
}

