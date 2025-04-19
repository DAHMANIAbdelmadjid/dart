import 'package:flutter/material.dart';
import 'package:flutter_auth/choose.dart';
// import 'package:flutter_auth/choose.dart';
import 'package:flutter_auth/login.dart';
import 'package:flutter_auth/sing_up.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const SignUp(), routes: {
      "login": (context) => const Login(),
      "signup": (context) => const SignUp(),
      "choose": (context) => const Choose(),
    });
  }
}
