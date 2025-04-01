import 'package:flutter/material.dart';
import 'settings.dart';
import 'subjects.dart';
import 'credits.dart';

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
          double aspectRatio = 16 / 9; // Set this to match your actual image aspect ratio

          return Center(
            child: SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: FittedBox(
                fit: BoxFit.cover, // Makes sure it expands to fill the screen
                child: SizedBox(
                  width: screenWidth,
                  height: screenWidth / aspectRatio, // Maintain image aspect ratio
                  child: Stack(
                    children: [
                      // ✅ Background Image (Expands to fit)
                      Positioned.fill(
                        child: Image.asset(
                          'assets/home.png',
                          fit: BoxFit.cover, // This fills the screen while keeping the ratio
                        ),
                      ),

                      // ✅ Play Button
                      Positioned(
                        left: screenWidth * 0.03,
                        top: (screenWidth / aspectRatio) * 0.29,
                        width: screenWidth * 0.28,
                        height: (screenWidth / aspectRatio) * 0.1,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SubjectsPage()),
                            );
                          },
                          child: Transform.rotate(
                            angle: -0.1,
                            child: Container(
                              color: Colors.red.withOpacity(0.3),
                            ),
                          ),
                        ),
                      ),

                      // ✅ Settings Button
                      Positioned(
                        left: screenWidth * 0.0,
                        top: (screenWidth / aspectRatio) * 0.45,
                        width: screenWidth * 0.3,
                        height: (screenWidth / aspectRatio) * 0.1,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SettingsPage()),
                            );
                          },
                          child: Transform.rotate(
                            angle: -0.05,
                            child: Container(
                              color: Colors.blue.withOpacity(0.3),
                            ),
                          ),
                        ),
                      ),

                      // ✅ Credits Button
                      Positioned(
                        left: screenWidth * 0.01,
                        top: (screenWidth / aspectRatio) * 0.6,
                        width: screenWidth * 0.29,
                        height: (screenWidth / aspectRatio) * 0.10,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CreditsPage()),
                            );
                          },
                          child: Transform.rotate(
                            angle: 0,
                            child: Container(
                              color: Colors.green.withOpacity(0.3),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
