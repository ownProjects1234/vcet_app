import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String sharedPreferenceUserNameKey = "userName";
  static String sharedPreferenceUserIdKey = "UserId";
  static String sharedPreferenceEmailKey = "Eamil";
  static String sharedPreferenceDeptKey = "Dept";
  static String sharedPreferenceAboutUsKey = "AboutUs";
  static String sharedPreferencePicKey = "picture";
  static String sharedPreferenceNameKey = "ProfileName";
  static String sharedPreferenceProfileKey = "ProfilePic";
  static String sharedPreferenceBgPicKey = "backGruodPic";
  static String sharedPreferenceQueryCounter = 'QueryCounter';
  static String sharedPreferenceEventCounter = 'EventCounter';

  static Future<bool> saveUserNameSharePreferences(String userName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserNameKey, userName);
  }

  static Future<bool> saveQueryCounterSharedPreferences(int q_counter) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setInt(sharedPreferenceQueryCounter, q_counter);
  }

  static Future<bool> saveEventCounterSharedPreferences(int e_Counter) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setInt(sharedPreferenceEventCounter, e_Counter);
  }

  static Future<bool> saveNameSharedPreferences(String Name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceNameKey, Name);
  }

  static Future<bool> saveProfileSharedPreferenceKey(String profilePic) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserNameKey, profilePic);
  }

  static Future<bool> savePicKeySharedPreferences(String picture) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferencePicKey, picture);
  }

  static Future<bool> saveBgPicKeySharedPreferenceKey(String bgPic) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceBgPicKey, bgPic);
  }

  static Future<bool> saveUserIdSharedPreferences(String userId) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceUserIdKey, userId);
  }

  static Future<bool> saveEmailSharedPreferences(String Email) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceEmailKey, Email);
  }

  static Future<bool> saveDeptKeySharedPreferences(String dept) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceDeptKey, dept);
  }

  static Future<bool> saveAboutUsSharedPreferences(String AboutUs) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(sharedPreferenceAboutUsKey, AboutUs);
  }

  static Future<String?> getUserNameSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceUserNameKey);
  }

  static Future<int?> getEventCounterSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(sharedPreferenceEventCounter);
  }

  static Future<int?> getQueryCounterSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(sharedPreferenceQueryCounter);
  }

  //  static Future<String> getNameSharedPreferences() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   return preferences.getString(sharedPreferenceNameKey);
  // }

  //  static Future<String> getProfileSharedPreferences() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   return preferences.getString(sharedPreferenceProfileKey)!;
  // }

  static Future<String?> getPicKeySharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferencePicKey);
  }

  static Future<String?> getBgPicKeySharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceBgPicKey);
  }

  static Future<String?> getEmailSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceEmailKey);
  }

  static Future<String?> getDeptSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceDeptKey);
  }

  static Future<String?> getAboutUsSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceAboutUsKey);
  }

  static Future<String?> getUserIdSharedPreference() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(sharedPreferenceUserIdKey);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  // decode bytes from a string
  static imageFrom64BaseString(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }
}
