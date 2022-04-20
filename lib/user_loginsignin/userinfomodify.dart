import 'package:con/user_loginsignin/mypage.dart';
import 'package:con/user_loginsignin/selectaffiliation.dart';
import 'package:con/user_loginsignin/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserInfoModify extends StatefulWidget {
  const UserInfoModify({Key? key}) : super(key: key);

  @override
  State<UserInfoModify> createState() => _UserInfoModifyState();
}

class _UserInfoModifyState extends State<UserInfoModify> {
  final _auth = FirebaseAuth.instance;
  //
  final nameEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? validateName(String? value) {
    RegExp regEx = new RegExp(r'^.{2,}$');
    if (value!.isEmpty) {
      return ('이름은 비워둘 수 없습니다.');
    }
    if (!regEx.hasMatch(value)) {
      return ('이름은 최소 2자리 이상 입력해주세요.');
    }
    return null;
  }

  String? validatePhone(String? value) {
    RegExp regEx = new RegExp(r'^[0-9]');
    RegExp regExx = new RegExp(r'^.{11,}$');
    if (value!.isEmpty) {
      return ('연락처는 비워둘 수 없습니다.');
    }
    if (!regEx.hasMatch(value)) {
      return ('연락처는 숫자만 입력할 수 있습니다.');
    }
    if (!regExx.hasMatch(value)) {
      return ('올바른 연락처를 입력해주세요.');
    }
    return null;
  }

  String? validateAffiliation(String? value) {
    if (value!.isEmpty) {
      return '소속을 골라주세요.';
    } else {
      return null;
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: '수정되었습니다.', backgroundColor: Colors.grey.shade800);
      postDetailsToFirestore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
      autofocus: false,
      controller: nameEditingController,
      keyboardType: TextInputType.name,
      validator: validateName,
      onSaved: (value) {
        nameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Padding(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          child: Icon(Icons.person),
        ),
        hintText: '이름',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
    final phoneField = TextFormField(
      autofocus: false,
      controller: phoneEditingController,
      keyboardType: TextInputType.number,
      validator: validatePhone,
      onSaved: (value) {
        phoneEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Padding(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          child: Icon(Icons.phone),
        ),
        hintText: '연락처',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
    final doneButton = Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(30),
      color: Colors.grey,
      child: MaterialButton(
        padding: const EdgeInsets.all(18),
        minWidth: double.infinity,
        onPressed: () {
          _submit();
        },
        child: const Text(
          '수정하기',
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        iconTheme: const CupertinoIconThemeData(color: Colors.black),
        elevation: 0,
        title: const Text(
          '정보수정',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        backgroundColor: Colors.grey[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  nameField,
                  const SizedBox(height: 10),
                  phoneField,
                  const SizedBox(height: 10),
                  const SelectAffWidget(),
                  const SizedBox(height: 30),
                  const Icon(Icons.announcement_outlined),
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      "수정 후 '내 정보' 페이지를 나갔다가 \n다시 들어오면 수정된 내용으로 보입니다!",
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(30.0),
        child: doneButton,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  postDetailsToFirestore() async {
    //파이어스토어 불러오기
    FirebaseFirestore firebasefirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = nameEditingController.text;
    userModel.phone = phoneEditingController.text;
    userModel.affiliation = myAffiliation!;

    await firebasefirestore
        .collection("users")
        .doc(user.uid)
        .update(userModel.toMap());

    Navigator.pop(
        (context), MaterialPageRoute(builder: (context) => const MyPage()));
  }
}
