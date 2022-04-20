import 'dart:ui';

import 'package:con/user_loginsignin/userinfomodify.dart';
import 'package:con/user_loginsignin/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../admin/adminpage.dart';
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
      appBar: AppBar(
        iconTheme: const CupertinoIconThemeData(color: Colors.black),
        elevation: 0,
        title: const Text(
          '내 정보',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        backgroundColor: Colors.grey[100],
      ),
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
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 30, right: 15),
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('images/SDGlogo.png'),
                                radius: 25.0,
                              ),
                            ),
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
                                Row(
                                  children: [
                                    Text("${loggedInUser.email}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey.shade600)),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            if (loggedInUser.admin != true)
                              Padding(
                                padding: const EdgeInsets.only(right: 30),
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  elevation: 1,
                                  color: Colors.white,
                                  minWidth: 10,
                                  onPressed: () {
                                    Navigator.push(
                                        (context),
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const UserInfoModify()));
                                  },
                                  child: const Text('편집'),
                                ),
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
                          title: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '소속',
                                  style: TextStyle(color: Colors.grey.shade500),
                                ),
                                Text('${loggedInUser.affiliation}'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 30),
                        color: Colors.white,
                        child: ListTile(
                          title: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('연락처',
                                    style:
                                        TextStyle(color: Colors.grey.shade500)),
                                Text('${loggedInUser.phone}'),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (loggedInUser.admin == true)
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: GestureDetector(
                                child: Text(
                                  '관리자 메뉴',
                                  style: TextStyle(
                                      color: Colors.lightGreen.shade800,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      (context),
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AdminPage()));
                                },
                              ),
                            ),
                          Padding(
                            padding: const EdgeInsets.only(right: 35.0),
                            child: GestureDetector(
                              child: Text(
                                '로그아웃',
                                style: TextStyle(color: Colors.grey.shade500),
                              ),
                              onTap: () {
                                logout(context);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox.fromSize(size: const Size(0, 30))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30.0, right: 30, top: 35, bottom: 10),
                  child: Row(
                    children: [
                      Container(
                          width: 60,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.lightGreen.shade600,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                              child: Text(
                            '주최',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ))),
                      const SizedBox(width: 20),
                      Expanded(
                          child: Text('환경부, 충청남도, 보령시, 2022 대한민국지속가능발전대회조직위원회',
                              style: TextStyle(
                                  color: Colors.grey.shade600, fontSize: 15))),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 30.0, right: 30, top: 10, bottom: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 60,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.lightGreen.shade600,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Center(
                              child: Text(
                            '주관',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ))),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Text(
                          '전국지속가능발전협의회, 충남지속가능발전협의회, 보령시지속가능발전협의회, 충남권지속가능발전협의회협력위원회, 이클레이한국사무소, 지속가능발전지방정부협의회, 지속가능발전학회',
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    width: 300,
                    height: 200,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/boryeong.png'),
                      ),
                    ))
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
