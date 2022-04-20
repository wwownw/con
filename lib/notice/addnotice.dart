import 'package:con/admin/noticeremove.dart';
import 'package:con/notice/noticemodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class AddNotice extends StatefulWidget {
  const AddNotice({Key? key}) : super(key: key);

  @override
  State<AddNotice> createState() => _AddNoticeState();
}

final fb = FirebaseDatabase.instance;

class _AddNoticeState extends State<AddNotice> {
  TextEditingController noticeTitle = TextEditingController();
  TextEditingController notice = TextEditingController();
  TextEditingController noticeCreator = TextEditingController();

  final ref = fb.ref().child('notice');

  String createdDateString =
      DateFormat.yMMMMd('en_US').add_jm().format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder _border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent, width: 0),
      borderRadius: BorderRadius.circular(20),
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: const CupertinoIconThemeData(color: Colors.black),
        elevation: 0,
        title: const Text(
          '공지 작성',
          style: TextStyle(color: Colors.black, fontSize: 18),
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
            child: Column(
              children: [
                TextField(
                  controller: noticeTitle,
                  decoration: InputDecoration(
                    prefix: const Padding(
                      padding: EdgeInsets.only(right: 12),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: _border,
                    enabledBorder: _border,
                    focusedBorder: _border,
                    hintText: '제목',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: noticeCreator,
                  decoration: InputDecoration(
                    prefix: const Padding(
                      padding: EdgeInsets.only(right: 12),
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    border: _border,
                    enabledBorder: _border,
                    focusedBorder: _border,
                    hintText: '작성자',
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  maxLines: 10,
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
              ],
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
              postDetailsToFirestore();
              Navigator.pop(context,
                  MaterialPageRoute(builder: (_) => const NoticeRemovePage()));
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

  postDetailsToFirestore() async {
    //파이어스토어 불러오기
    FirebaseFirestore firebasefirestore = FirebaseFirestore.instance;

    NoticeModel noticeModel =
        NoticeModel(notice: notice.text, noticeTitle: noticeTitle.text);

    noticeModel.notice = notice.text;
    noticeModel.noticeTitle = noticeTitle.text;
    noticeModel.created = createdDateString;
    noticeModel.creator = noticeCreator.text;

    await firebasefirestore
        .collection("notice")
        .doc('$createdDateString, ${noticeTitle.text}')
        .set(noticeModel.toMap());
  }
}
