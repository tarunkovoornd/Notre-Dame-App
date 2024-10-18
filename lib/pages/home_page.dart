import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String welcomeMessage = 'Welcome to Notre Dame High School!';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Text(
          welcomeMessage,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
