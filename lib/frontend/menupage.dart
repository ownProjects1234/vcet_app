import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vcet/backend/post/cached_image.dart';
import 'package:vcet/backend/providers/get_user_info.dart';
import 'package:vcet/chat/helper/helper_functions.dart';
import 'package:vcet/colorClass.dart';
import 'package:vcet/frontend/clubs/rotaract.dart';
import 'package:vcet/frontend/notification.dart';
import 'package:vcet/frontend/profile.dart';

class Menuitem {
  static const home = MenuItems("Home", Icons.home_outlined);

  static const profile = MenuItems("Profile", Icons.person);
  static const busroute = MenuItems("Bus Route", Icons.bus_alert);
  static const library = MenuItems("Library", Icons.my_library_books_rounded);
  static const quiz = MenuItems("Quiz", Icons.quiz_outlined);
  // static const websitelogin = MenuItems("Web login", Icons.web);

  static const chat = MenuItems("Chat", Icons.chat);

  static const all = <MenuItems>[
    home,
    profile,
    busroute,
    library,
    quiz,
    //  websitelogin,
    chat,
  ];
}

class menupage extends StatefulWidget {
  final MenuItems currentItem;
  final ValueChanged<MenuItems> onSelectedItem;
  const menupage({
    Key? key,
    required this.currentItem,
    required this.onSelectedItem,
  }) : super(key: key);

  @override
  State<menupage> createState() => _menupageState();
}

class _menupageState extends State<menupage> {
  final items = ['Rotaract Club', 'Club 2', 'Club 3'];
  String? value;
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
  }

  String userName = '';
  Image? Img;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    HelperFunctions.getUserNameSharedPreferences().then((value) {
      setState(() {
        userName = value!;
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
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser?.rollNo)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          var datas = snapshot.data;
          return Theme(
              data: ThemeData.dark(),
              child: Scaffold(
                backgroundColor: Colors.indigo,
                body: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0, left: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            buildprofileimage(),
                            Container(
                              height: 20,
                              width: 100,
                              // color: Colors.red,
                              child: Center(
                                child: Text((currentUser?.name)!,
                                    maxLines: 2,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                              ),
                            )
                          ],
                        ),
                      ),

                      const Spacer(),
                      ...Menuitem.all.map(buildMenuItems).toList(),

                      // ),
                      Row(
                        children: [
                          IconButton(
                              padding: EdgeInsets.only(left: 13),
                              onPressed: () async {
                                final url = 'http://vcet.ac.in';
                                if (await canLaunch(url)) {
                                  await launch(url,
                                      forceWebView: true,
                                      enableJavaScript: true);
                                }
                              },
                              icon: Icon(Icons.web)),
                          Padding(padding: EdgeInsets.only(left: 13)),
                          GestureDetector(
                            onTap: () async {
                              final url = datas['staff'] == false
                                  ? 'http://vcet.ac.in/vcetattendance/ParentsLogin.php'
                                  : 'http://vcet.ac.in/vcetattendance/Login.php';

                              if (await canLaunch(url)) {
                                await launch(url,
                                    forceWebView: true, enableJavaScript: true);
                              }
                            },
                            child: const Text(
                              "Website login",
                              style: TextStyle(fontSize: 16
                                  // fontWeight: FontWeight.w500, color: Colors.white
                                  ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 7),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          width: 200,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: Colors.black, width: 2)),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              hint: const Text("CLUBS"),
                              onChanged: (String? value) {
                                setState(() {
                                  this.value = value;
                                });
                              },
                              items: items.map<DropdownMenuItem<String>>(
                                  (String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    // onTap: () {
                                    //   Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //           builder: (context) =>
                                    //               displayPage(subj: dropDownStringItem)));
                                    // },
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    rotaract()));
                                      },
                                      child: Text(
                                        dropDownStringItem,
                                        maxLines: 1,
                                        style: TextStyle(color: Colors.white),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ));
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 20)),
                      const Spacer(
                        flex: 1,
                      ),
                      const SizedBox(
                        height: 1,
                        child: Divider(
                          color: Colors.white,
                          height: 1,
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  padding: EdgeInsets.only(left: 13),
                                  onPressed: () async {
                                    final phonenumber = '9994994991';
                                    final url = 'tel:$phonenumber';
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    }
                                  },
                                  icon: Icon(Icons.contact_mail)),
                              Padding(padding: EdgeInsets.only(left: 13)),
                              GestureDetector(
                                onTap: () async {
                                  final phonenumber = '9994994991';
                                  final url = 'tel:$phonenumber';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  }
                                },
                                child: const Text(
                                  "Contact Us",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                  padding: EdgeInsets.only(left: 13),
                                  onPressed: () async {
                                    final toemail =
                                        'fluttervcetappdev@gmail.com';
                                    final subject =
                                        'feedback about vcet application';
                                    final message = 'Hello developers!!!';
                                    final url =
                                        'mailto:$toemail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}';
                                    if (await canLaunch(url)) {
                                      await launch(url);
                                    }
                                  },
                                  icon: Icon(Icons.feedback_sharp)),
                              Padding(padding: EdgeInsets.only(left: 13)),
                              GestureDetector(
                                onTap: () async {
                                  final toemail = 'fluttervcetappdev@gmail.com';
                                  final subject =
                                      'feedback about vcet application';
                                  final message = 'Hello developers!!!';
                                  final url =
                                      'mailto:$toemail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}';
                                  if (await canLaunch(url)) {
                                    await launch(url);
                                  }
                                },
                                child: const Text(
                                  "Feedback",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ));
        });
  }

  Widget buildMenuItems(MenuItems item) => ListTileTheme(
        selectedColor: Colors.white,
        child: ListTile(
          selectedTileColor: Colors.black26,
          selected: widget.currentItem == item,
          minLeadingWidth: 20,
          leading: Icon(item.icon),
          title: Text(item.title),
          onTap: () => widget.onSelectedItem(item),
        ),
      );

  Widget buildprofileimage() {
    return CircleAvatar(
      radius: (profileheight / 3) + 2,
      backgroundColor: myColors.buttonColor,
      child: CircleAvatar(
          child: Container(
            decoration: BoxDecoration(),
          ),
          radius: profileheight / 3,
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage((currentUser?.photourl)!)),
    );
  }

  Image? img() {
    // if (Img == null) return const Image(image: AssetImage('images/logo1.webp'));

    // return Image.file(
    //   image!,
    //   fit: BoxFit.cover,
    // );
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
}

class MenuItems {
  final String title;
  final IconData icon;
  const MenuItems(this.title, this.icon);
}
