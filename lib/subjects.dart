import 'package:flutter/material.dart';
import 'package:myapp/main.dart';
import 'math_difficulty.dart';
import 'english_difficulty.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;
          double aspectRatio = 448 / 207; // Set this to match your actual image aspect ratio

          return Center(
            child: SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: FittedBox(
                fit: BoxFit.fill, // Makes sure it expands to fill the screen
                child: SizedBox(
                  width: screenWidth,
                  height: screenWidth / aspectRatio, // Maintain image aspect ratio
                  child: Stack(
                    children: [
                      // ✅ Background Image (Expands to fit)
                      Positioned.fill(
                        child: SvgPicture.asset(
                          'assets/subjects.svg',
                          fit: BoxFit.cover, // This fills the screen while keeping the ratio
                        ),
                      ),

                      // ✅ Back Button
                      Positioned(
                        left: screenWidth * 0.05,
                        top: (screenWidth / aspectRatio) * 0.78,
                        width: screenWidth * 0.125,
                        height: (screenWidth / aspectRatio) * 0.1,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyApp()),
                            );
                          },
                          child: Transform.rotate(
                            angle: -0.12,
                            child: Container(
                              color: Colors.red.withOpacity(0.0),
                            ),
                          ),
                        ),
                      ),

                     
                      // ✅ English Difficulty Button
                      Positioned(
                        left: screenWidth * 0.32,
                        top: (screenWidth / aspectRatio) * 0.615,
                        width: screenWidth * 0.105,
                        height: (screenWidth / aspectRatio) * 0.165,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EnglishDifficulty()),
                            );
                          },
                          child: Transform.rotate(
                            angle: 0.1,
                            child: Container(
                              color: Colors.green.withOpacity(0.0),
                            ),
                          ),
                        ),
                      ),
                       // ✅ Math Difficulty Button
                      Positioned(
                        left: screenWidth * 0.185,
                        top: (screenWidth / aspectRatio) * 0.615,
                        width: screenWidth * 0.106,
                        height: (screenWidth / aspectRatio) * 0.165,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MathDifficulty()),
                            );
                          },
                          child: Transform.rotate(
                            angle: -0.05,
                            child: Container(
                              color: Colors.blue.withOpacity(0.0),
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
