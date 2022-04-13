import 'package:con/preclass_quiz/preclassintro.dart';
import 'donatepage.dart';
import 'package:flutter/material.dart';

class Advertise {
  List advertises = [
    Image.asset('images/2022.jpeg', fit: BoxFit.cover),
    Image.asset('images/dndkd.png'),
  ];
}

class MainBanner {
  List banner = [
    const BBanner(),
    const BBBanner(),
  ];
}

class BBanner extends StatelessWidget {
  const BBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const PreclassIntroPage()));
        },
      ),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
    );
  }
}

class BBBanner extends StatelessWidget {
  const BBBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const DonatePage()));
        },
      ),
      decoration: BoxDecoration(
          color: Colors.grey[400], borderRadius: BorderRadius.circular(20)),
    );
  }
}
