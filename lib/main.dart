import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const NotreDameApp());
}

class NotreDameApp extends StatelessWidget {
  const NotreDameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      primarySwatch: Colors.blue,
    );

    return MaterialApp(
      title: 'Notre Dame High School App',
      theme: theme,
      home: const LoginPage(),
    );
  }
}
