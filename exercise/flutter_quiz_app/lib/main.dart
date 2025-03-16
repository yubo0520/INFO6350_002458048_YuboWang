import 'package:flutter/material.dart';
import 'quiz_screen.dart'; 

void main() {
  runApp(const QuizApp());
}

// app entry point
class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const QuizScreen(), // set home screen
    );
  }
}