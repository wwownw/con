import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'user_loginsignin/login.dart';

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
    return OverlaySupport(
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.grey),
        debugShowCheckedModeBanner: false,
        home: const LoginPage(),
      ),
    );
  }
}
