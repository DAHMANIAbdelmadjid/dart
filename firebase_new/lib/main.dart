import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_new/home_page.dart';
import 'package:firebase_new/sin_up.dart';
import 'package:firebase_new/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        if (kDebugMode) {
          debugPrint('User is currently signed out!');
        }
      } else {
        if (kDebugMode) {
          debugPrint('User is signed in!');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Login(),
      // home: FirebaseAuth.instance.currentUser == null
      //     ? const Login()
      //     : const MyHomePage(),
      routes: {
        "signup": (context) => const SinUp(),
        "login": (context) => const Login(),
        "homepage": (context) => const MyHomePage(),
      },
    );
  }
}
