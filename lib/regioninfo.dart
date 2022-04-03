import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: const CupertinoIconThemeData(color: Colors.black),
        elevation: 0,
        title: const Text(
          '지역정보',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey[100],
      ),
      body: const Center(
          // child: FutureBuilder(
          //   future: this.fetch(),
          //   builder: (context, snap) {
          //     if (!snap.hasData) return CircularProgressIndicator();
          //     return Text(snap.data.toString());
          //   },
          // ),
          ),
    );
  }
}
