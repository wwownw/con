import 'dart:io';

import 'package:con/document/pdfapi.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:con/document/storageservice.dart';
import 'package:con/document/pdfviewpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilePage extends StatefulWidget {
  const FilePage({Key? key}) : super(key: key);

  @override
  State<FilePage> createState() => _FilePageState();
}

class _FilePageState extends State<FilePage> {
  final fb = firebase_storage.FirebaseStorage.instance;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final Storage storage = Storage();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: const CupertinoIconThemeData(color: Colors.black),
        elevation: 0,
        title: const Text(
          '행사자료',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        backgroundColor: Colors.grey[100],
      ),
      body: FutureBuilder(
        future: storage.listFiles(),
        builder: (BuildContext context,
            AsyncSnapshot<firebase_storage.ListResult> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.items.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () async {
                      final url = snapshot.data!.items[index].name;
                      final file = await PDFapi.loadFirebase(url);
                      if (file == null) return;
                      openPDF(context, file);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 5),
                      height: 50,
                      width: size.height,
                      child: Center(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                snapshot.data!.items[index].name,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.grey.shade800),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
          if (snapshot.connectionState == ConnectionState.waiting ||
              !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return const Text('파일이 없습니다.');
        },
      ),
    );

    // body: Center(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       MaterialButton(
    //         minWidth: 10,
    //         child: const Text('asset'),
    //         //asset에서 가져오기
    //         onPressed: () async {
    //           const path = 'images/lifestyle.pdf';
    //           final file = await PDFapi.loadAsset(path);
    //           openPDF(context, file);
    //         },
    //       ),
    //       MaterialButton(
    //         minWidth: 10,
    //         child: const Text('pdflink'),
    //         //pdf링크 바로열기
    //         onPressed: () async {
    //           final url = 'http://md.egloos.com/file/pdf_sample.pdf';
    //           final file = await PDFapi.loadNetwork(url);
    //           openPDF(context, file);
    //         },
    //       ),
    //       MaterialButton(
    //         minWidth: 10,
    //         child: const Text('file'),
    //         //폰 파일중에서 고르기
    //         onPressed: () async {
    //           final file = await PDFapi.pickFile();
    //           if (file == null) {
    //             openPDF(context, file!);
    //           }
    //         },
    //       ),
    //       MaterialButton(
    //         minWidth: 10,
    //         child: const Text('firebase'),
    //         //폰 파일중에서 고르기
    //         onPressed: () async {
    //           final url = 'lifestyle.pdf';
    //           final file = await PDFapi.loadFirebase(url);
    //           if (file == null) return;
    //           openPDF(context, file);
    //         },
    //       ),
    //     ],
    //   ),
    // ),
  }

  Future<void> openPDF(BuildContext context, File file) async =>
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)));
}
