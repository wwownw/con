import 'package:flutter/cupertino.dart';

import 'home_info.dart';
import 'package:flutter/material.dart';

class LockState {
  bool lockstate = false;

  void locate() {
    if (true) {
      lockstate = false;
    }
  }

  void visited() {
    if (true) {
      lockstate = false;
    }
  }
}

class CouponPage extends StatefulWidget {
  const CouponPage({Key? key}) : super(key: key);

  @override
  _CouponPageState createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {
  @override
  Widget build(BuildContext context) {
    //TODO: 쿠폰 이미지 띄울때 타이머같은거라도 설정해서 중복사용방지
    return Scaffold(
      appBar: AppBar(
        iconTheme: CupertinoIconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          '쿠폰',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.grey[100],
      ),
      body: SafeArea(
        child: ListView(
            scrollDirection: Axis.vertical,
            children: [couponcard(context, const InfoPage())]),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}

Padding couponcard(BuildContext context, StatefulWidget coupon) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10),
    child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => coupon));
        },
        child: Container(
          width: 380,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage('images/dndkd.png')),
          ),
        ),
      ),
    ),
  );
}
