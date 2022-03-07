import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_info.dart';

class QnaPage extends StatefulWidget {
  const QnaPage({Key? key}) : super(key: key);

  @override
  State<QnaPage> createState() => _QnaPageState();
}

class _QnaPageState extends State<QnaPage> {
  @override
  Widget build(BuildContext context) {
    //TODO: 알림톡같은거 자동답변 걸어놔도 좋을 것 같당
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: CupertinoIconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          '문의',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey[100],
      ),
    );
  }
}
