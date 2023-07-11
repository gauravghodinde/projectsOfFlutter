import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 7, 255, 52),
        body: Center(
          child: Text(
            'Hello World!',
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 32),
          ),
        ),
      ),
    );
  }
}
