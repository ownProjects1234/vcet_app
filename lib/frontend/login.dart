// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:vcet/backend/API/usersapi.dart';
import 'package:vcet/chat/helper/helper_functions.dart';
import 'package:vcet/chat/models/user.dart';
import 'package:vcet/frontend/background.dart';

class loginpage extends StatefulWidget {
  loginpage({Key? key}) : super(key: key);

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  String UserId() {
    return _idController.text;
  }

  String Password() {
    return _pwController.text;
  }

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  final TextEditingController _otpController = TextEditingController();

  // String? finalName;

  // Future getValidationData() async {
  //   String obtainedName = await HelperFunctions.getUserNameSharedPreferences();
  //   setState(() {
  //     finalName = obtainedName;
  //   });
  //   print(finalName);
  // }

  String name = "";
  final _formkey = GlobalKey<FormState>();
  // static TextEditingController idController = TextEditingController();
  // static TextEditingController pwController = TextEditingController();

  // Future<String> UserId() async {
  //   return await idController.text;
  // }

  // Future<String> Password() async {
  //   return await pwController.text;
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          body: background_page(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formkey,
              child: Column(children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: const Text(
                    "LOGIN",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2661FA),
                        fontSize: 36),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter your user id / roll number";
                      } else {
                        return null;
                      }
                    },
                    //  textCapitalization: TextCapitalization.sentences,
                    controller: widget._idController,
                    decoration: const InputDecoration(
                      labelText: "User Id",
                      hintText: "Enter your user id / roll number",
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter password";
                      } else {
                        return null;
                      }
                    },
                    controller: widget._pwController,
                    decoration: const InputDecoration(
                        labelText: "Password", hintText: "DD/MM/YYYY"),
                    obscureText: true,
                  ),
                )
              ]),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: const Text(
                "DOB is your password",
                style: TextStyle(fontSize: 12, color: Color(0XFF2661FA)),
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Container(
                alignment: Alignment.centerRight,
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                // ignore: deprecated_member_use
                child: RaisedButton(
                    onPressed: () {
                      setState(() {
                        String id = widget._idController.text;
                        String dob = widget._pwController.text;
                        User(uid: id);
                        if (id.isEmpty || dob.isEmpty) {
                          Future(() {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: const Text(
                                      "Enter Roll number or Password",
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        loginpage()));
                                          },
                                          child: const Text("Ok"))
                                    ],
                                  );
                                });
                          });
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UserApi(id: id, dob: dob)));
                        }
                      });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      width: size.width * 0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80.0),
                          gradient: const LinearGradient(colors: [
                            Color.fromARGB(255, 255, 136, 34),
                            Color.fromARGB(255, 255, 177, 41)
                          ])),
                      padding: const EdgeInsets.all(0),
                      child: const Text(
                        "LOGIN",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ))),
          ],
        ),
      )),
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
