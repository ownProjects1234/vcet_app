import 'package:flutter/material.dart';

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

class menupage extends StatelessWidget {
  final MenuItems currentItem;
  final ValueChanged<MenuItems> onSelectedItem;
  const menupage({
    Key? key,
    required this.currentItem,
    required this.onSelectedItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: Colors.indigo,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              ...MenuItem.all.map(buildMenuItems).toList(),
              Spacer(
                flex: 2,
              )
            ],
          ),
        ),
      ));
  Widget buildMenuItems(MenuItems item) => ListTileTheme(
        selectedColor: Colors.white,
        child: ListTile(
          selectedTileColor: Colors.black26,
          selected: currentItem == item,
          minLeadingWidth: 20,
          leading: Icon(item.icon),
          title: Text(item.title),
          onTap: () => onSelectedItem(item),
        ),
      );
}

class MenuItems {
  final String title;
  final IconData icon;
  const MenuItems(this.title, this.icon);
}
