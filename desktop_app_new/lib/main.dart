import 'package:desktop_app_new/home.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const DesktopApp());
}

class DesktopApp extends StatelessWidget {
  const DesktopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home()
      );
  }
}
