import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:vcet/chat/helper/helper_functions.dart';

import 'package:vcet/chat/pages/chat_page.dart';
import 'package:vcet/chat/services/database_service.dart';
import 'package:vcet/frontend/login.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchEditingController = TextEditingController();
  late QuerySnapshot searchResultSnapshot;
  bool isLoading = false;
  bool hasUserSearched = false;
  bool _isJoined = false;
  String _userName = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  loginpage user = loginpage();

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
  
    _getCurrentUserNameAndUid();
  }

  _getCurrentUserNameAndUid() async {
    await HelperFunctions.getUserNameSharedPreferences().then((value) {
      _userName = value;
    });
  }

  _initiateSearch() async {
    if (searchEditingController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await DatabaseService(uid: _userName)
          .searchByName(searchEditingController.text)
          .then((snapshot) {
        searchResultSnapshot = snapshot;
        print("$searchResultSnapshot");
        setState(() {
          isLoading = false;
          hasUserSearched = true;
        });
      });
    }
  }

  void _showScaffold(String message, $groupName) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.blueAccent,
      duration: const Duration(milliseconds: 1500),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 17.0),
      ),
    ));
  }

  _joinValueInGroup(
      String userName, String groupId, String groupName, String admin) async {
    bool value = await DatabaseService(uid: _userName)
        .isUserJoined(groupId, groupName, userName);

    setState(() {
      _isJoined = value;
    });
  }

  Widget groupList() {
    return hasUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchResultSnapshot.docs.length,
            itemBuilder: (context, index) {
              return groupTile(
                  _userName,
                  searchResultSnapshot.docs[index].data()['groupId'],
                  searchResultSnapshot.docs[index].data()['groupName'],
                  searchResultSnapshot.docs[index].data()['admin']);
            },
          )
        : Container();
  }

  Widget groupTile(
      String userName, String groupId, String groupName, String admin) {
    _joinValueInGroup(userName, groupId, groupName, admin);
    return GestureDetector(
      onTap: () {
        _isJoined
            ? Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatPage(
                          groupId: groupId,
                          userName: userName,
                          groupName: groupName,
                        )))
            : null;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          leading: CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.blueAccent,
            child: Text(groupName.substring(0, 1).toUpperCase(),
                style: TextStyle(color: Colors.white)),
          ),
          title: Text(
            groupName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
       
      subtitle: Text("Admin: $admin"),)
     
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
      elevation:  0.0,
      backgroundColor: Colors.black87,
      title: const Text('Search', style: TextStyle(fontSize: 27.0, fontWeight: FontWeight.bold, color: Colors.white),),
      ),
      body: Container(
        child: Column(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              color: Colors.grey[700],
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchEditingController,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: const InputDecoration(
                        hintText: "Search groups...",
                        hintStyle: TextStyle(
                          color: Colors.white38,
                          fontSize: 16,
                        ),
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      _initiateSearch();
                    },
                    child: Container(
                      height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(40)
                        ),
                        child:const Icon(Icons.search, color: Colors.white)
                    )
                  )
                ],
              ),
            
          ),
          isLoading ? Container(child: const Center(child: CircularProgressIndicator(),)) : groupList()
        ],),
      ),
    );

  }
}
