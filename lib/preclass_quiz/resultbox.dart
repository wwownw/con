import 'package:con/home.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({
    Key? key,
    required this.result,
    required this.questionLength,
  }) : super(key: key);

  final int result;
  final int questionLength;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: background,
      content: Padding(
        padding: const EdgeInsets.only(top: 30, bottom: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '내 점수',
              style: TextStyle(color: Colors.black),
            ),
            const SizedBox(height: 15),
            CircleAvatar(
              radius: 50,
              backgroundColor: result == questionLength / 2
                  ? Colors.yellow.shade800
                  : result < questionLength / 2
                      ? incorrect
                      : correct,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$result',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '/$questionLength',
                    style: TextStyle(
                        color: Colors.white.withAlpha(100),
                        fontSize: 30,
                        fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              elevation: 0.5,
              hoverColor: Colors.white,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    (context),
                    MaterialPageRoute(builder: (context) => HomeItem()),
                    (route) => false);
              },
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  '저장하고 나가기',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//서버에 결과 저장하고 홈으로 나가는 기능
