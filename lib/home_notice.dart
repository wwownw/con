import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_info.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  @override
  Widget build(BuildContext context) {
    //TODO: 외부 게시판이랑 연동 (웹뷰?)
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: CupertinoIconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          '행사공지',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey[100],
      ),
    );
  }
}
