import 'package:con/coupon/couponcard.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import '../information.dart';

class CouponPage extends StatefulWidget {
  const CouponPage({Key? key}) : super(key: key);

  @override
  _CouponPageState createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const CupertinoIconThemeData(color: Colors.black),
        elevation: 0,
        title: const Text(
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
