import 'package:con/user_loginsignin/selectaffiliation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:con/user_loginsignin/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login.dart';

class RegisterationScreen extends StatefulWidget {
  const RegisterationScreen({Key? key}) : super(key: key);

  @override
  _RegisterationScreenState createState() => _RegisterationScreenState();
}

class _RegisterationScreenState extends State<RegisterationScreen> {
  //
  final _auth = FirebaseAuth.instance;
  //
  final _formKey = GlobalKey<FormState>();
  //
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();
  //
  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ('이메일은 비워둘 수 없습니다.');
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+_.-].[a-z]")
            .hasMatch(value)) {
          return ('올바른 이메일을 적어주세요.');
        }
        return null;
      },
      onSaved: (value) {
        emailEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Padding(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          child: Icon(Icons.email),
        ),
        hintText: '이메일',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      validator: (value) {
        RegExp regEx = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ('사용할 비밀번호를 입력해주세요.');
        }
        if (!regEx.hasMatch(value)) {
          return ('비밀번호는 최소 6자리 이상입니다.');
        }
      },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Padding(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          child: Icon(Icons.vpn_key),
        ),
        hintText: '비밀번호',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,
      validator: (value) {
        if (value!.isEmpty) {
          return ('비밀번호를 한번 더 입력해주세요.');
        }
        if (confirmPasswordEditingController.text !=
            passwordEditingController.text) {
          return ('비밀번호를 다시 확인해주세요.');
        }
      },
      onSaved: (value) {
        confirmPasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Padding(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          child: Icon(Icons.vpn_key),
        ),
        hintText: '비밀번호 확인',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
    final signinButton = Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(30),
      color: Colors.grey,
      child: MaterialButton(
        padding: const EdgeInsets.all(18),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUP(emailEditingController.text, passwordEditingController.text);
        },
        child: const Text(
          '다음으로',
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    '로그인 시 사용할 \n이메일과 비밀번호를 적어주세요',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  emailField,
                  const SizedBox(height: 10),
                  passwordField,
                  const SizedBox(height: 10),
                  confirmPasswordField,
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
        child: signinButton,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void signUP(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  postDetailsToFirestore() async {
    //파이어스토어 불러오기
    FirebaseFirestore firebasefirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;

    await firebasefirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const RegisterationNext()),
        (route) => false);
  }
}

class RegisterationNext extends StatefulWidget {
  const RegisterationNext({Key? key}) : super(key: key);

  @override
  State<RegisterationNext> createState() => _RegisterationNextState();
}

class _RegisterationNextState extends State<RegisterationNext> {
  final _auth = FirebaseAuth.instance;
  //
  final _formKey = GlobalKey<FormState>();
  //
  final nameEditingController = new TextEditingController();
  final phoneEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final nameField = TextFormField(
      autofocus: false,
      controller: nameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regEx = new RegExp(r'^.{2,}$');
        if (value!.isEmpty) {
          return ('이름은 비워둘 수 없습니다.');
        }
        if (!regEx.hasMatch(value)) {
          return ('이름은 최소 2자리 이상 입력해주세요.');
        }
        return null;
      },
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
      keyboardType: TextInputType.phone,
      validator: (value) {
        RegExp regEx = new RegExp('^[0-9]');
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
      },
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
          if (nameEditingController.text != null) {
            if (nameEditingController.text != null) {
              if (myAffiliation != null) {
                // ignore: void_checks
                return postDetailsToFirestore();
              }
            }
          }
        },
        child: const Text(
          '완료',
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              children: const [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    '좋습니다! \n사용자 정보를 알려주세요',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
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
                  const SizedBox(height: 15),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20.0),
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
    userModel.affiliation = myAffiliation;

    await firebasefirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: '정상적으로 가입되었습니다.', backgroundColor: Colors.grey);

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const Loginpp()),
        (route) => false);
  }
}
