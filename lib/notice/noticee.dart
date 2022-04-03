import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Noticee extends StatefulWidget {
  const Noticee({Key? key}) : super(key: key);

  @override
  State<Noticee> createState() => _NoticeeState();
}

class _NoticeeState extends State<Noticee> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: const CupertinoIconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.grey[100],
      ),
      body: Scaffold(
        backgroundColor: Colors.grey.shade100,
      ),
    );
  }
}
