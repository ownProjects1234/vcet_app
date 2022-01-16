import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vcet/chat/helper/helper_functions.dart';
import 'package:vcet/frontend/drawers.dart';
import 'package:vcet/frontend/firstpage.dart';

class Detail extends StatefulWidget {
  final String fromWhere;
  const Detail({Key? key, required this.fromWhere}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();

  final TextEditingController department = TextEditingController();

  final TextEditingController aboutus = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  File? image;
  // encodes bytes list as string

  var val = 15.0;
  final double coverheight = 240;
  final double profileheight = 144;
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
    final bottom = profileheight / 2;
    final top = coverheight - profileheight / 2;
    return Scaffold(
        body: Form(
      key: formkey,
      child: ListView(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                  margin: EdgeInsets.only(bottom: bottom),
                  child: buildcoverimage()),
              Positioned(top: top, child: buildprofileimage())
            ],
          ),
          SizedBox(
            height: val,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Material(
              elevation: 7,
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextFormField(
                controller: username,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    // icon: Icon(Icons.ac_unit),
                    labelText: "Username",
                    hintText: " Enter your name",
                    labelStyle: const TextStyle(
                        letterSpacing: 2, fontWeight: FontWeight.bold),
                    hintStyle: const TextStyle(
                      letterSpacing: 2,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                    fillColor: Colors.white30,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
                validator: (String? value) {
                  if (value!.isNotEmpty && value.length > 3) {
                    return null;
                  }
                  if (value.isEmpty) {
                    return "please enter user name";
                  }
                  if (value.length < 4) {
                    return "Please enter valid username";
                  }
                },
              ),
            ),
          ),
          SizedBox(
            height: val,
          ),
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Material(
                elevation: 7,
                shadowColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      labelText: "Email",
                      labelStyle: const TextStyle(
                          letterSpacing: 2,
                          // color: Colors.amber,
                          fontWeight: FontWeight.bold),
                      hintText: "example@gmail.com",
                      hintStyle: const TextStyle(
                        letterSpacing: 2,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                      fillColor: Colors.white30,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Email';
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return 'Please a valid Email';
                    }
                    return null;
                  },
                ),
              )),
          SizedBox(
            height: val,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Material(
              elevation: 7,
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextFormField(
                controller: department,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.category),
                    labelText: "Department",
                    hintText: "ECE/ece",
                    labelStyle: const TextStyle(
                        letterSpacing: 2,
                        // color: Colors.amber,
                        fontWeight: FontWeight.bold),
                    hintStyle: const TextStyle(
                      letterSpacing: 2,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                    fillColor: Colors.white30,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
                validator: (String? value) {
                  if (value == 'ece' ||
                      value == 'ECE' ||
                      value == "CSE" ||
                      value == 'cse' ||
                      value == 'EEE' ||
                      value == "eee" ||
                      value == 'it' ||
                      value == 'IT' ||
                      value == "mech" ||
                      value == 'MECH' ||
                      value == 'CIVIL' ||
                      value == "civil" ||
                      value == 'PHYSICS' ||
                      value == 'Maths') {
                    return null;
                  }
                  return "Please enter valid department name";
                },
              ),
            ),
          ),
          SizedBox(
            height: val,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Material(
              elevation: 7,
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextFormField(
                controller: aboutus,
                decoration: InputDecoration(
                    errorStyle: TextStyle(
                      color: Colors.red,
                    ),
                    labelText: "About us",
                    hintText: "Write about yourself",
                    labelStyle: const TextStyle(
                        letterSpacing: 2,
                        // color: Colors.amber,
                        fontWeight: FontWeight.bold),
                    hintStyle: const TextStyle(
                      letterSpacing: 2,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                    fillColor: Colors.white30,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Please write about yourself";
                  }
                  if (value.length < 20) {
                    return "Limit not reached";
                  }
                  return null;
                },
              ),
            ),
          ),
          SizedBox(
            height: val + 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context, builder: ((builder) => bottomSheet()));
                },
                child: const Text(
                  "Edit Image",
                  style: TextStyle(
                      fontSize: 15, letterSpacing: 2, color: Colors.black),
                ),
                style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
              ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    HelperFunctions.saveUserNameSharePreferences(username.text);
                    HelperFunctions.saveEmailSharedPreferences(email.text);
                    HelperFunctions.saveDeptKeySharedPreferences(
                        department.text);
                    HelperFunctions.saveAboutUsSharedPreferences(aboutus.text);

                    if (image == null) return;

                    final imagetem = image!.readAsBytesSync();

                    HelperFunctions.savePicKeySharedPreferences(
                        HelperFunctions.base64String(imagetem));

                    if (widget.fromWhere == "userApi") {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => drawers()));
                    }
                    //else if (image == null) {
                    //   Future(() {
                    //     showDialog(
                    //         context: context,
                    //         builder: (context) {
                    //           return const AlertDialog(
                    //             content: Text(
                    //               "Please select Profile Picture",
                    //               style: TextStyle(color: Colors.red),
                    //             ),
                    //           );
                    //         });
                    //   });
                    else if (widget.fromWhere == "profile") {
                      Navigator.pop(context);
                    }
                  } else {
                    return;
                  }
                },
                child: const Text(
                  "Submit",
                  style: TextStyle(
                      fontSize: 15, letterSpacing: 2, color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
              )
            ],
          ),
          SizedBox(
            height: val + 8.0,
          ),
          const Padding(
              padding: EdgeInsets.only(
                  top: 5.0, bottom: 8.0, left: 8.0, right: 15.0),
              child: Text(
                "Image is mandatory before submition",
                style: TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.w400),
              ))

          /* ListView(
            // mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                color: Colors.red,
                padding: EdgeInsets.only(top: 80),
                height: double.infinity,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: ListView(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textfields("Enter your username", "Username"),
                    textfields("Enter Email id", "Email"),
                    textfields("department", "Department"),
                    textfields("Write about yourself", "About you"),
                  ],
                ),
              ),
              Row()
            ],
          ),*/
        ],
      ),
    ));
  }

  Widget buildprofileimage() {
    return CircleAvatar(
      radius: profileheight / 2,
      backgroundColor: Colors.white,
      backgroundImage: img().image,
    );
  }

  Widget buildcoverimage() {
    return Container(
      color: Colors.grey,
      child: Image.network(
        "https://images.shiksha.com/mediadata/images/1573812713php8IGcGI.jpeg",
        width: double.infinity,
        height: coverheight,
        fit: BoxFit.cover,
      ),
    );
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
                  onPressed: () {
                    pickImage(ImageSource.camera);
                    // HelperFunctions.savePicKeySharedPreferences(
                    //   HelperFunctions.base64String(image!.readAsBytesSync()));
                  },
                  icon: Icon(Icons.camera)),
              const Text(
                "Camera",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.only(left: 20)),
              IconButton(
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                    // HelperFunctions.savePicKeySharedPreferences(
                    //   HelperFunctions.base64String(image!.readAsBytesSync()));
                  },
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
      return Image.asset(
        "images/logo1.webp",
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        image!,
        fit: BoxFit.fitWidth,
      );
    }
  }
}
