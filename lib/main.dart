import 'package:flutter/material.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override Widget build(BuildContext context) => MaterialApp(
    title: 'sprearn.bd',
    home: Scaffold(
      backgroundColor: Color(0xFF0a0b0f),
      body: Center(child: Text('sprearn.bd', style: TextStyle(color: Color(0xFFc6ff00), fontSize: 28, fontWeight: FontWeight.bold))),
    ),
  );
}