import 'package:flutter/material.dart';
import 'math_easy.dart';
import 'subjects.dart';
import 'math_medium.dart';
import 'math_hard.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MathDifficulty extends StatelessWidget {
  const MathDifficulty({super.key});

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
          double aspectRatio =
              448 / 207; // Set this to match your actual image aspect ratio

          return Center(
            child: SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: FittedBox(
                fit: BoxFit.fill, // Makes sure it expands to fill the screen
                child: SizedBox(
                  width: screenWidth,
                  height:
                      screenWidth / aspectRatio, // Maintain image aspect ratio
                  child: Stack(
                    children: [
                      // ✅ Background Image (Expands to fit)
                      Positioned.fill(
                        child: SvgPicture.asset(
                          'assets/mathdifficulty.svg',
                          fit: BoxFit
                              .cover, // This fills the screen while keeping the ratio
                        ),
                      ),

                      //✅Back Button
                      Positioned(
                        left: screenWidth * 0.05,
                        top: (screenWidth / aspectRatio) * 0.06,
                        width: screenWidth * 0.12,
                        height: (screenWidth / aspectRatio) * 0.135,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SubjectsPage()),
                            );
                          },
                          child: Transform.rotate(
                            angle: -0.23,
                            child: Container(
                              color: Colors.red.withOpacity(0.0),
                            ),
                          ),
                        ),
                      ),
                      // ✅ Easy Button
                      Positioned(
                        left: screenWidth * 0.18,
                        top: (screenWidth / aspectRatio) * 0.345,
                        width: screenWidth * 0.16,
                        height: (screenWidth / aspectRatio) * 0.17,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MathEasy()),
                            );
                          },
                          child: Transform.rotate(
                            angle: 0.0,
                            child: Container(
                              color: Colors.red.withOpacity(0.0),
                            ),
                          ),
                        ),
                      ),
                      // ✅ Medium Button
                      Positioned(
                        left: screenWidth * 0.39,
                        top: (screenWidth / aspectRatio) * 0.345,
                        width: screenWidth * 0.16,
                        height: (screenWidth / aspectRatio) * 0.17,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MathMedium()),
                            );
                          },
                          child: Transform.rotate(
                            angle: 0.0,
                            child: Container(
                              color: Colors.red.withOpacity(0.0),
                            ),
                          ),
                        ),
                      ),
                      // ✅ Hard Button
                      Positioned(
                        left: screenWidth * 0.63,
                        top: (screenWidth / aspectRatio) * 0.345,
                        width: screenWidth * 0.16,
                        height: (screenWidth / aspectRatio) * 0.17,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MathHard()),
                            );
                          },
                          child: Transform.rotate(
                            angle: 0.0,
                            child: Container(
                              color: Colors.red.withOpacity(0.0),
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
