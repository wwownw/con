import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Confe());
}

class Confe extends StatefulWidget {
  const Confe({Key? key}) : super(key: key);

  @override
  State<Confe> createState() => _ConfeState();
}

class _ConfeState extends State<Confe> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.grey),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
