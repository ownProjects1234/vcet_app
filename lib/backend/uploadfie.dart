import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vcet/frontend/Appbar.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({ Key? key }) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbars("Upload"),
      
    );
  }
}