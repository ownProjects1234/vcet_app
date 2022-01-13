// ignore_for_file: camel_case_types

import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:open_file/open_file.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vcet/backend/API/downloadApi.dart';
import 'package:vcet/backend/firebase_file.dart';
import 'package:vcet/frontend/Appbar.dart';

class displayPage extends StatefulWidget {
  const displayPage({Key? key}) : super(key: key);

  @override
  _displayPageState createState() => _displayPageState();
}

class _displayPageState extends State<displayPage> {
  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    futureFiles = DownloadApi.listAll('BEIE/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbars("Download Files"),
      body: FutureBuilder<List<FirebaseFile>>(
        future: futureFiles,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              if (snapshot.hasError) {
                return (const Center(child: Text('Some error occurred!')));
              } else {
                final files = snapshot.data!;

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3
                      
                      ),
                  itemCount: files.length,
                
                  itemBuilder: (context, index) {
                    final file = files[index];

                    return GestureDetector(
                      onTap: () => openFile(url: file.url, fileName: file.name),
                      child: Card(
                        
                        elevation: 10.0,
                        margin:const EdgeInsets.all(8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                        ),
                          color: Colors.blue[400], child: buildFile(context, file)),
                    );
                  },
                );
              }
          }
        },
      ),
    );
  }

  Widget buildFile(BuildContext context, FirebaseFile file) => Column(
    children:  [
      Image.asset("images/pdfImage.jpg",
      height: 80.0,
      width: 120.0,
      fit: BoxFit.fill,
      
      ),
      Container(
      decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),

              ],
            ),
      ),
      const SizedBox(height: 8.0,),
      Center(
        child: Text(file.name,
        maxLines: 1,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black,
        
        ),
        ),
      )
    

    ],
    
  
  );



  Future openFile({required String url, String? fileName}) async {
    final file = await downloadFile(url, fileName!);
    if (file == null) return;
    print('Path: ${file.path}');

    OpenFile.open(file.path);
  }

  Future<File?> downloadFile(String url, String name) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$name');
    try {
      final response = await Dio().get(url,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              receiveTimeout: 0));

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      return file;
    } catch (e) {
      return null;
    }
  }
}
