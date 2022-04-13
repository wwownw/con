import 'package:con/user_loginsignin/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../adminpage.dart';
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
                              padding: EdgeInsets.only(left: 30, right: 15),
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 30.0,
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
                            Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                elevation: 1,
                                color: Colors.white,
                                minWidth: 10,
                                onPressed: () {},
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
                                child: const Text(
                                  '관리자 메뉴',
                                  style: TextStyle(
                                      color: Colors.deepOrangeAccent,
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
