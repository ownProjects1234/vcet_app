import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vcet/chat/helper/helper_functions.dart';
import 'package:vcet/colorClass.dart';
import 'package:vcet/frontend/detail.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  String? uid;

  File? image;
  final double profileheight = 144;
  final double coverheight = 240;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      //print(image);

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    final imagetem = image!.readAsBytesSync();
    HelperFunctions.savePicKeySharedPreferences(
        HelperFunctions.base64String(imagetem));
  }

  String userName = '';
  String mailId = '';
  String About = '';
  Image? Img;
  String UserID = '';
  String ImgString = '';

  // getInfo() async {
  //   userName = await HelperFunctions.getUserNameSharedPreferences();
  //   mailId = await HelperFunctions.getEmailSharedPreferences();
  //   About = await HelperFunctions.getAboutUsSharedPreferences();
  //   Img = await HelperFunctions.getPicKeySharedPreferences();
  // }

  @override
  void initState() {
    super.initState();
    getInfo();
  }

  getInfo() async {
    HelperFunctions.getUserNameSharedPreferences().then((value) {
      setState(() {
        userName = value!;
      });
    });
    HelperFunctions.getEmailSharedPreferences().then((value) {
      setState(() {
        mailId = value!;
      });
    });

    HelperFunctions.getAboutUsSharedPreferences().then((value) {
      setState(() {
        About = value!;
      });
    });

    HelperFunctions.getPicKeySharedPreferences().then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        Img = HelperFunctions.imageFrom64BaseString(value);
      });
    });

    HelperFunctions.getUserIdSharedPreference().then((value) {
      setState(() {
        UserID = value!;
        uid = value;
      });
    });
    print(UserID);
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController aboutUsController = TextEditingController();

  @override
  // ignore: dead_code
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
        return WillPopScope(
          onWillPop: () => _onWillPop(),
          child: Scaffold(
              backgroundColor: myColors.secondaryColor,
              // extendBodyBehindAppBar: true,
              extendBody: true,
              appBar: AppBar(
                elevation: 0.0,
                centerTitle: true,
                backgroundColor: Colors.transparent,
                title: const Text(
                  "Profile",
                  style: TextStyle(
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
                //elevation: 0,
                //backgroundColor: Color(0XFF0C9869),
                // title: Text("Profile"),
                // centerTitle: true,
                leading: IconButton(
                    onPressed: () => ZoomDrawer.of(context)!.toggle(),
                    icon: Icon(Icons.menu)),
              ),
              body: Container(
                padding: EdgeInsets.only(top: 30),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.indigo.shade50,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60.0),
                            topRight: Radius.circular(60.0))),
                    height: 700,
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        left: 15, top: 20, right: 15, bottom: 10),
                    child: ListView(
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              buildprofileimage(),
                              /* Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 4, color: Colors.black),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.1))
                                  ],
                                  shape: BoxShape.circle,
                                  image: DecorationImage(image: img().image))
                                  ),*/
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 1, color: Colors.black),
                                        color: Colors.teal),
                                    child: IconButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: ((builder) =>
                                                  bottomSheet()));
                                          // HelperFunctions
                                          //     .savePicKeySharedPreferences(
                                          //         HelperFunctions.base64String(
                                          //             image!.readAsBytesSync()));
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "NAME:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            Padding(padding: EdgeInsets.only(left: 250)),
                            IconButton(
                                onPressed: () async {
                                  // final name = await openDialog(
                                  //     "ENTER YOUR NAME", "Enter your name");
                                  // if (name == null || name.isEmpty) return;
                                  // setState(() {
                                  //   userName = name;
                                  //   HelperFunctions.saveUserNameSharePreferences(
                                  //       userName);
                                  // });

                                  showDialog<String>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title:
                                                const Text("ENTER YOUR NAME"),
                                            content: TextField(
                                              controller: userNameController,
                                              autofocus: true,
                                              decoration: const InputDecoration(
                                                  hintText: "Enter your name"),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  userName =
                                                      userNameController.text;

                                                  HelperFunctions
                                                      .saveUserNameSharePreferences(
                                                          userNameController
                                                              .text);

                                                  // userName =
                                                  //     userNameController.text;

                                                  Navigator.pop(context);
                                                },
                                                child: Text("SUBMIT"),
                                              )
                                            ],
                                          ));
                                  // setState(() {
                                  //   userName = userNameController.text;
                                  // });
                                },
                                icon: Icon(
                                  Icons.edit,
                                )),
                          ],
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(padding: EdgeInsets.only(left: 15)),
                            const Icon(
                              Icons.person_rounded,
                              color: Colors.black,
                            ),
                            const Padding(padding: EdgeInsets.only(left: 25)),
                            Text(
                              userName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                  fontSize: 17),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "EMAIL:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Padding(padding: EdgeInsets.only(left: 250)),
                            IconButton(
                                onPressed: () async {
                                  // final names = await openDialog(
                                  //     "ENTER YOUR MAIL ID", "Enter your mail");
                                  // if (names == null || names.isEmpty) return;
                                  // setState(() {
                                  //   mailId = names;
                                  // });
                                  showDialog<String>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: const Text(
                                                "ENTER YOUR MAIL ID"),
                                            content: TextField(
                                              controller: emailController,
                                              autofocus: true,
                                              decoration: const InputDecoration(
                                                  hintText:
                                                      "Enter your mail id"),
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    mailId =
                                                        emailController.text;

                                                    HelperFunctions
                                                        .saveEmailSharedPreferences(
                                                            emailController
                                                                .text);

                                                    // mailId = emailController.text;
                                                    // HelperFunctions.saveEmailSharedPreferences(
                                                    //     emailController.text);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("SUBMIT"))
                                            ],
                                          ));
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                )),
                          ],
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(padding: EdgeInsets.only(left: 15)),
                            const Icon(Icons.email, color: Colors.black),
                            const Padding(padding: EdgeInsets.only(left: 25)),
                            Text(
                              mailId,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                  fontSize: 17),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        (datas['staff'] == 'false') ? const Text(
                          "ROLL NO:",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ): const Text(
                                "USER ID:",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Padding(padding: EdgeInsets.only(left: 15)),
                            const Icon(Icons.code_sharp, color: Colors.black),
                            const Padding(padding: EdgeInsets.only(left: 25)),
                            Text(
                              UserID,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                  fontSize: 17),
                            ),
                            // IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            (datas['staff'] == 'false') ? const Text(
                              "ABOUT US:",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ): const Text(
                                    "MAJOR FIELD:",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                           const Padding(padding: EdgeInsets.only(left: 200)),
                            IconButton(
                                onPressed: () async {
                                  // final namess = await openDialog(
                                  //     "WRITE ABOUT YOURSELF", "Write about you");
                                  // if (namess == null || namess.isEmpty) return;
                                  // setState(() {
                                  //   About = namess;
                                  // });
                                  showDialog<String>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: const Text(
                                                "WRITE ABOUT YOURSELF"),
                                            content: TextField(
                                              controller: aboutUsController,
                                              autofocus: true,
                                              decoration: const InputDecoration(
                                                  hintText:
                                                      "Write about yourself"),
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    About =
                                                        aboutUsController.text;

                                                    HelperFunctions
                                                        .saveAboutUsSharedPreferences(
                                                            aboutUsController
                                                                .text);

                                                    // About =
                                                    //     aboutUsController.text;
                                                    // HelperFunctions.saveAboutUsSharedPreferences(
                                                    //     aboutUsController.text);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("SUBMIT"))
                                            ],
                                          ));
                                  // setState(() {
                                  //   About = aboutUsController.text;
                                  //   // HelperFunctions.saveAboutUsSharedPreferences(
                                  //   //     aboutUsController.text);
                                  // });
                                },
                                icon: const Icon(Icons.edit,
                                    color: Colors.black)),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(left: 30)),

                        // const Padding(padding: EdgeInsets.only(left: 25)),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            About,
                            maxLines: 5,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                fontSize: 17),
                          ),
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.all(10.0),
                        //   child: ElevatedButton(
                        //       onPressed: () {
                        //         Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //                 builder: (context) => Detail(fromWhere: "profile",)));
                        //       },
                        //       child: Text("Submit")),
                        // )
                      ],
                    ),
                  ),
                ),
              )),
        );
      },
    );
  }

  // Future<String?> openDialog(fieldname, hintname) => showDialog<String>(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //           title: Text(fieldname),
  //           content: TextField(
  //             controller: controllers,
  //             autofocus: true,
  //             decoration: InputDecoration(hintText: hintname),
  //           ),
  //           actions: [TextButton(onPressed: submit, child: Text("SUBMIT"))],
  //         ));
  // void submit() {
  //   Navigator.of(context).pop(controllers.text);
  // }

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
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        pickImage(ImageSource.camera);
                        // HelperFunctions.savePicKeySharedPreferences(
                        //     HelperFunctions.base64String(image!.readAsBytesSync()));
                      },
                      icon: Icon(Icons.camera)),
                  GestureDetector(
                    onTap: () {
                      pickImage(ImageSource.camera);
                    },
                    child: const Text(
                      "Camera",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Padding(padding: EdgeInsets.only(left: 20)),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        pickImage(ImageSource.gallery);
                        // HelperFunctions.savePicKeySharedPreferences(
                        //     HelperFunctions.base64String(image!.readAsBytesSync()));
                      },
                      icon: Icon(Icons.image)),
                  GestureDetector(
                    onTap: () {
                      pickImage(ImageSource.gallery);
                    },
                    child: const Text(
                      "Gallery",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Image? img() {
    // if (image == null) {
    //   return Image(
    //     image: AssetImage('images/logo1.webp'),
    //   );
    // } else {
    //   return Image.file(
    //     image!,
    //     fit: BoxFit.cover,
    //   );
    // }

    if (image == null) {
      if (Img == null) {
        return const Image(
          image: AssetImage('images/logo1.webp'),
        );
      } else {
        return Img;
      }
    } else {
      return Image.file(image!, fit: BoxFit.cover);
    }
  }

  Widget buildprofileimage() {
    return CircleAvatar(
      radius: (profileheight / 2) + 5,
      backgroundColor: Colors.black,
      child: CircleAvatar(
        child: Container(
          decoration: BoxDecoration(),
        ),
        radius: profileheight / 2,
        backgroundColor: Colors.white,
        backgroundImage: img()?.image,
      ),
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

  Future<bool> _onWillPop() async {
    final shouldpop = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          TextButton(
            onPressed: () => exit(0),
            /*Navigator.of(context).pop(true)*/
            child: Text('Yes'),
          ),
        ],
      ),
    );

    return shouldpop ?? false;
  }
}
