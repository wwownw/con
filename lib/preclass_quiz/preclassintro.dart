import 'package:con/preclass_quiz/preclassquiz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PreclassIntroPage extends StatefulWidget {
  const PreclassIntroPage({Key? key}) : super(key: key);

  @override
  State<PreclassIntroPage> createState() => _PreclassIntroPageState();
}

bool alreadyPressedq = false;

class _PreclassIntroPageState extends State<PreclassIntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: const CupertinoIconThemeData(color: Colors.black),
        elevation: 0,
        title: const Text(
          '',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        backgroundColor: Colors.grey[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              children: const [
                Expanded(
                  child: Text(
                    '퀴즈 참여하고 기프티콘 받자!',
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  '2022년 7월 2일까지 참여 가능',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: const [
                Expanded(
                  child: Text(
                    '참여해주신 분들께 기프티콘을 쏩니다! \n퀴즈는 한 번만 참여 가능합니다.',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 350,
                decoration: const BoxDecoration(
                    image:
                        DecorationImage(image: AssetImage('images/quiz.png'))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: alreadyPressedq
                  ? MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      height: 65,
                      color: Colors.grey,
                      onPressed: () {
                        Fluttertoast.showToast(
                            msg: '이미 참여하셨습니다.',
                            backgroundColor: Colors.grey.shade800);
                      },
                      child: const Center(
                        child: Text(
                          '사전퀴즈 참여하기',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    )
                  : MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      height: 65,
                      color: Colors.lightGreen.shade700,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const PreclassPage()));
                      },
                      child: const Center(
                        child: Text(
                          '나도 참여하기',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
