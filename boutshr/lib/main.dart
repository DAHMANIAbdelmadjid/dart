import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tabibe',
      theme: getApplicationTheme(),
      locale: const Locale("ar"),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // T dsasd
      supportedLocales: S.delegate.supportedLocales,
      // initialRoute: AppRoutes.login,
      // routes: AppRoutes.getRoutes(),
      home: const LoginScreen(),
    );
  }
}
