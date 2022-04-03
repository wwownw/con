import 'package:con/home.dart';
import 'package:con/user_loginsignin/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('error'),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    // return SignInScreen(
                    //     providerConfigs: [EmailProviderConfiguration()]);
                    return const Loginpp();
                  } else {
                    return HomeItem();
                  }
                });
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}

class Loginpp extends StatefulWidget {
  const Loginpp({Key? key}) : super(key: key);

  @override
  _LoginppState createState() => _LoginppState();
}

class _LoginppState extends State<Loginpp> {
  //
  final _formKey = GlobalKey<FormState>();
  //
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //
  final _auth = FirebaseAuth.instance;
  //
  @override
  Widget build(BuildContext context) {
    //이메일
    final emailField = TextFormField(
      autofocus: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ('이메일을 적어주세요.');
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+_.-].[a-z]")
            .hasMatch(value)) {
          return ('올바른 이메일을 적어주세요.');
        }
        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
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
    //비밀번호
    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      validator: (value) {
        RegExp regEx = new RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ('비밀번호를 입력해주세요.');
        }
        if (!regEx.hasMatch(value)) {
          return ('비밀번호는 최소 6자리 이상입니다.');
        }
        return null;
      },
      onSaved: (value) {
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
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
    final loginButton = Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(30),
      color: Colors.grey,
      child: MaterialButton(
        padding: const EdgeInsets.all(18),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signIn(emailController.text, passwordController.text);
        },
        child: const Text(
          '로그인',
          style: TextStyle(
              fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(35),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              emailField,
              const SizedBox(height: 10),
              passwordField,
              const SizedBox(height: 20),
              loginButton,
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('계정이 없어요!   '),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RegisterationScreen()));
                    },
                    child: const Text(
                      '가입하기',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(
                    msg: '로그인 되었습니다.', backgroundColor: Colors.grey.shade800),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomeItem()))
              })
          .catchError((e) {
        Fluttertoast.showToast(
            msg: '이메일과 비밀번호를 다시 확인해주세요.',
            backgroundColor: Colors.grey.shade800);
      });
    }
  }
}
