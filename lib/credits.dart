import 'package:flutter/material.dart';
import 'main.dart';

class CreditsPage extends StatelessWidget {
  const CreditsPage({super.key});

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
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/credits.png'),
                      fit: BoxFit.cover, // Covers the whole screen
                    ),
                  ),
                ),
              ),

              // Invisible Back Button (Responsive to screen size)
              Positioned(
                left: screenWidth * 0.02, // 5% from left
                bottom: screenHeight * 0.15, // 5% from bottom
                width: screenWidth * 0.18, // 20% of screen width
                height: screenHeight * 0.11, // 8% of screen height
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyApp()),
                    );
                  },
                  child: Transform.rotate(
                    angle: -0.12, // Adjust rotation angle in radians
                    child: Container(
                      color: Colors.red.withOpacity(0.3), // Debugging overlay
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
