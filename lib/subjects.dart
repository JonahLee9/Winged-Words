import 'package:flutter/material.dart';
import 'math_difficulty.dart';
import 'english_difficulty.dart';

class SubjectsPage extends StatelessWidget {
  const SubjectsPage({super.key});

   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BackgroundScreen(),
    );
  }
}

class BackgroundScreen extends StatelessWidget {
  const BackgroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/subjects.png'),
            fit: BoxFit.cover, // Covers the whole screen
          ),
        ),
      ),
    );
  }
}
