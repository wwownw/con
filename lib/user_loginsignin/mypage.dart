import 'package:con/user_loginsignin/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  //
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            color: Colors.grey.shade100,
            height: 50,
          ),
          SafeArea(
            child: Column(
              children: [
                Material(
                  color: Colors.grey.shade100,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 30, right: 20),
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 30.0,
                              ),
                            ),
                            const SizedBox(height: 15.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("${loggedInUser.name}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 22.0)),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Text('로그아웃'),
                                  color: Colors.white,
                                  onPressed: () {
                                    logout(context);
                                  }),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 30),
                        color: Colors.white,
                        child: ListTile(
                          leading: const Icon(
                            Icons.festival,
                            color: Colors.grey,
                          ),
                          title: Text('${loggedInUser.attached}'),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 30),
                        color: Colors.white,
                        child: ListTile(
                          leading: const Icon(
                            Icons.call,
                            color: Colors.grey,
                          ),
                          title: Text('${loggedInUser.phone}'),
                        ),
                      ),
                      SizedBox.fromSize(size: const Size(0, 30))
                    ],
                  ),
                ),
                // Row(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.only(top: 30, left: 30, bottom: 15),
                //       child: Text(
                //         '내가 고른 세미나',
                //         style: TextStyle(fontSize: 16),
                //       ),
                //     ),
                //   ],
                // ),
                Column(
                  children: [
                    SizedBox.fromSize(size: const Size(0, 30)),
                    tpalsk(context, '실론나이트쿠키', '7/2, 14:00-16:00, 대천초등학교',
                        Colors.lightGreen.shade100),
                    tpalsk(context, '수호의 성전', '7/3, 09:00-11:00, 컨벤션홀',
                        Colors.amber.shade100),
                    tpalsk(context, '길드 업데이트', '7/4, 13:00-14:00, 컴퓨터실',
                        Colors.lightBlue.shade100),
                    SizedBox.fromSize(size: const Size(0, 10)),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 30),
                      color: Colors.grey.shade100,
                      child: const ListTile(
                        leading: Icon(Icons.add),
                        title: Text('관심 세미나 추가하기'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Loginpp()));
  }
}

Card tpalsk(BuildContext context, String title, String subtitle, Color color) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
    color: color,
    child: ListTile(
      title: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Text(title),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Text(subtitle),
      ),
      trailing: GestureDetector(
        child: const Padding(
          padding: EdgeInsets.only(right: 5.0),
          child: Icon(Icons.cancel_outlined),
        ),
      ),
    ),
  );
}
