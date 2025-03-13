import 'package:flutter/material.dart';
import 'dart:math';
import 'subjects.dart';
import 'credits.dart';
// Needed for rotation in radians

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;

          return Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  'assets/home.png',
                  fit: BoxFit.cover,
                ),
              ),

              // Play Button (Responsive)
              Positioned(
                left: screenWidth * 0.08, // 13% of screen width
                top: screenHeight * 0.28, // 24% of screen height
                width: screenWidth * 0.25, // 35% of screen width
                height: screenHeight * 0.11, // 7% of screen height
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SubjectsPage()),
                    );
                  },
                  child: Transform.rotate(
                    angle: -0.1, // Adjust rotation angle in radians
                    child: Container(
                      color: Colors.red.withOpacity(0.3), // Debugging overlay
                    ),
                  ),
                ),
              ),

              // Settings Button (Responsive)
              Positioned(
                left: screenWidth * 0.05,
                top: screenHeight * 0.45,
                width: screenWidth * 0.27,
                height: screenHeight * 0.11,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingsScreen()),
                    );
                  },
                  child: Transform.rotate(
                    angle: -0.05, // Adjust rotation angle
                    child: Container(
                      color: Colors.blue.withOpacity(0.3),
                    ),
                  ),
                ),
              ),

              // Credits Button (Responsive)
              Positioned(
                left: screenWidth * 0.07,
                top: screenHeight * 0.60,
                width: screenWidth * 0.25,
                height: screenHeight * 0.10,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CreditsPage()),
                    );
                  },
                  child: Transform.rotate(
                    angle: 0, // No rotation needed
                    child: Container(
                      color: Colors.green.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Placeholder Screens
class PlayScreen extends StatelessWidget {
  const PlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Play')),
      body: const Center(child: Text('Play Screen')),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(child: Text('Settings Screen')),
    );
  }
}

class CreditsScreen extends StatelessWidget {
  const CreditsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Credits')),
      body: const Center(child: Text('Credits Screen')),
    );
  }
}
