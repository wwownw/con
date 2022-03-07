import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:core';

import 'home_info.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Future fetch() async {
    var res = await http.get(Uri.parse('http://192.168.10.107:3000/'),
        headers: {'userHeader': '1234'});
    return json.decode(res.body);
  }

  @override
  Widget build(BuildContext context) {
    //TODO: 카카오맵 API 연결해야함
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: CupertinoIconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          '지도',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey[100],
      ),
      body: Center(
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
