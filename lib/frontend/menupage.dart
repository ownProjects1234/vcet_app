import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vcet/chat/helper/helper_functions.dart';

class MenuItem {
  static const home = MenuItems("Home", Icons.home_outlined);

  static const profile = MenuItems("Profile", Icons.person);
  static const busroute = MenuItems("Bus Route", Icons.bus_alert);
  static const library = MenuItems("Library", Icons.my_library_books_rounded);
  static const notification =
      MenuItems("Notification", Icons.notification_important_rounded);
  static const upload = MenuItems("Upload", Icons.cloud_upload);
  static const chat = MenuItems("Chat", Icons.chat);

  static const all = <MenuItems>[
    home,
    profile,
    busroute,
    library,
    notification,
    upload,
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
    getInfo();
  }

  getInfo() async {
    if (userName == '') {
      HelperFunctions.getUserNameSharedPreferences().then((value) {
        setState(() {
          userName = value;
        });
      });
    } else {
      HelperFunctions.getNameSharedPreferences().then((value) {
        setState(() {
          userName = value;
        });
      });
    }

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
    return Theme(
        data: ThemeData.dark(),
        child: Scaffold(
          backgroundColor: Colors.indigo,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, left: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Padding(padding: EdgeInsets.all(20)),
                      buildprofileimage(),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, top: 9),
                        child: Text(userName,
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                ...MenuItem.all.map(buildMenuItems).toList(),
                const Spacer(
                  flex: 2,
                )
              ],
            ),
          ),
        ));
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
      backgroundColor: Colors.black,
      child: CircleAvatar(
        child: Container(
          decoration: BoxDecoration(),
        ),
        radius: profileheight / 3,
        backgroundColor: Colors.white,
        backgroundImage: img()!.image,
      ),
    );
  }

  Image? img() {
    if (image == null) return Img;

    return Image.file(
      image!,
      fit: BoxFit.cover,
    );
  }
}

class MenuItems {
  final String title;
  final IconData icon;
  const MenuItems(this.title, this.icon);
}
