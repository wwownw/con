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

Padding couponcard(BuildContext context, StatefulWidget coupon) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
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
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('images/dndkd.png')),
          ),
        ),
      ),
    ),
  );
}
