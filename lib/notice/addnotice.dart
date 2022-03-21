import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'notice.dart';

class AddNotice extends StatelessWidget {
  TextEditingController notice = TextEditingController();

  final fb = FirebaseDatabase.instance;

  AddNotice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder _border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent, width: 0),
      borderRadius: BorderRadius.circular(20),
    );

    final ref = fb.ref().child('notice');

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: const CupertinoIconThemeData(color: Colors.black),
        elevation: 0,
        title: const Text(
          '공지 작성',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey[100],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: notice,
              decoration: InputDecoration(
                prefix: const Padding(
                  padding: EdgeInsets.only(right: 12),
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: _border,
                enabledBorder: _border,
                focusedBorder: _border,
                hintText: '공지사항',
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          MaterialButton(
            color: Colors.grey[900],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: () {
              ref
                  .push()
                  .set(
                    notice.text,
                  )
                  .asStream();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const NoticePage()));
            },
            child: const Text(
              "업로드",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
