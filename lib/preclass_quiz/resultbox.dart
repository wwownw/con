import 'package:con/home.dart';
import 'package:con/preclass_quiz/preclassintro.dart';
import 'package:con/user_loginsignin/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class ResultBox extends StatefulWidget {
  const ResultBox({
    Key? key,
    required this.result,
    required this.questionLength,
  }) : super(key: key);

  final int result;
  final int questionLength;

  @override
  State<ResultBox> createState() => _ResultBoxState();
}

class _ResultBoxState extends State<ResultBox> {
  final fb = FirebaseDatabase.instance;

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final ref = fb.ref().child('quizResult');

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
              backgroundColor: widget.result == widget.questionLength / 2
                  ? Colors.yellow.shade800
                  : widget.result < widget.questionLength / 2
                      ? incorrect
                      : correct,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${widget.result}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '/${widget.questionLength}',
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
                ref.child('${loggedInUser.phone}').set(
                  {
                    'affiliation': loggedInUser.affiliation,
                    'name': loggedInUser.name,
                    'phone': loggedInUser.phone,
                    'result': widget.result
                  },
                ).asStream();
                Navigator.pushAndRemoveUntil(
                    (context),
                    MaterialPageRoute(builder: (context) => HomeItem()),
                    (route) => false);
                setState(() {
                  alreadyPressedq = true;
                });
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

class QuizResult {
  final String id;
  final String phone;
  final Map<String, String> result;

  QuizResult({
    required this.id,
    required this.phone,
    required this.result,
  });

  @override
  String toString() {
    return 'Result(id: $id, phone: $phone, result: $result)';
  }
}
