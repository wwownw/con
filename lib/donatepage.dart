import 'package:con/user_loginsignin/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DonatePage extends StatefulWidget {
  const DonatePage({Key? key}) : super(key: key);

  @override
  State<DonatePage> createState() => _DonatePageState();
}

final fb = FirebaseDatabase.instance;

bool alreadyPressed = false;

class _DonatePageState extends State<DonatePage> {
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

  final ref = fb.ref().child('donatedUser');

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
                Text(
                  '같이 동참해주세요!',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
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
                    '아래의 나도 참여하기 버튼을 누르면 참가비의 \n일부가 나무 한그루가 됩니다.',
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
                    image: DecorationImage(
                        image: AssetImage('images/donate.png'))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: alreadyPressed
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
                          '소중한 참여 감사합니다.',
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
                        ref.child('${loggedInUser.phone}').set(
                          {
                            'affiliation': loggedInUser.affiliation,
                            'name': loggedInUser.name,
                            'phone': loggedInUser.phone,
                          },
                        ).asStream();
                        setState(() {
                          alreadyPressed = true;
                        });
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
