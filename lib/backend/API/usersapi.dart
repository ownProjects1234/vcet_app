// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vcet/backend/User/setUser.dart';
import 'package:vcet/backend/providers/get_user_info.dart';
import 'package:vcet/chat/helper/helper_functions.dart';
import 'package:vcet/frontend/detail.dart';
import 'package:vcet/frontend/drawers.dart';

import 'package:vcet/frontend/firstpage.dart';
import 'package:vcet/frontend/login.dart';

import 'package:vcet/frontend/snackbartext.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../frontend/alert_box.dart';

class UserApi extends StatefulWidget {
  String id;
  String dob;
  UserApi({
    Key? key,
    required this.id,
    required this.dob,
  }) : super(key: key);

  @override
  _UserApiState createState() => _UserApiState();
}

class _UserApiState extends State<UserApi> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    final TextEditingController _otpController = TextEditingController();
    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(widget.id).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return const SnackBar(content: Text("Something went wrong"));
          } else if (snapshot.hasData && !snapshot.data!.exists) {
            Future(() {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: const Text("Enter valid Username"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => loginpage()));
                            },
                            child: const Text("Ok"))
                      ],
                    );
                  });
            });
          } else if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> docFields =
                snapshot.data!.data() as Map<String, dynamic>;

            // return Text("username is : ${docFields['rollNo']}");
            String rollNo = docFields['rollNo'];
            // ignore: non_constant_identifier_names
            String Dob = docFields['dob'];
            String email = docFields['email'];

          

            if (rollNo.compareTo(widget.id) == 0 &&
                Dob.compareTo(widget.dob) == 0) {
              Future(() async {
                // final SharedPreferences sharedPreferenceUserNameKey =
                //     await SharedPreferences.getInstance();
                // sharedPreferenceUserNameKey.setString('RollNo', widget.id);
                // await HelperFunctions.saveUserNameSharePreferences(widget.id);
                // final SharedPreferences sharedPreferenceUserIdKey =
                //     await SharedPreferences.getInstance();
                // sharedPreferenceUserIdKey.setString('Password', widget.dob);
                
                void sendOtp() async {
                  EmailAuth(sessionName: "Text Session");
                  var res = await EmailAuth(sessionName: "Text Session")
                      .sendOtp(recipientMail: email);
                }

                void verifyOtpTouserApi() async {
                  var res = EmailAuth(sessionName: 'Test Session').validateOtp(
                      recipientMail: email, userOtp: _otpController.text);
                  if (res) {
                    await HelperFunctions.saveUserIdSharedPreferences(
                        widget.id);
                    print("Otp verified");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Detail(fromWhere: "UserApi", rollNo: rollNo)));
                  }
                  else{
                     Future(() {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: const Text(
                                "Invalid Otp",
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
                  }
                }

                void verifyOtpToDrawer() async {
                  var res = EmailAuth(sessionName: 'Test Session').validateOtp(
                      recipientMail: email, userOtp: _otpController.text);
                  if (res) {
                    print("Otp verified");
                    await HelperFunctions.saveUserIdSharedPreferences(
                        widget.id);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => drawers()));
                  }else{
                     Future(() {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: const Text(
                                "Invalid Otp",
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

                  }
                }

                if (docFields['name'] == "") {
                  sendOtp();
                  Future(() {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('An otp is sent to the $email',style: TextStyle(fontSize: 12),),
                              content: TextFormField(
                                controller: _otpController,
                                autofocus: true,
                                decoration: const InputDecoration(
                                    hintText: "Enter the otp"),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () => verifyOtpTouserApi(),
                                    child: const Text("Submit"))
                              ],
                            ));
                  });
                 
                } else {
                  
                  sendOtp();
                  
                  await firebasefirestore().getUserInfo(widget.id);


                  Future(() {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text('An otp is sent to the *$email*',
                                style: TextStyle(fontSize: 14),
                              ),
                              content: TextFormField(
                                controller: _otpController,
                                autofocus: true,
                                decoration: const InputDecoration(
                                    hintText: "Enter the otp"),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () => verifyOtpToDrawer(),
                                    child: const Text("Submit"))
                              ],
                            ));
                  });
                  
                }
              });
            } else if (Dob.compareTo(widget.dob) != 0) {
              Future(() {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: const Text(
                          "Enter valid Username or Password",
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => loginpage()));
                              },
                              child: const Text("Ok"))
                        ],
                      );
                    });
              });
            } else {
              return const SnackBar(content: Text("Something went wrong"));
            }
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
