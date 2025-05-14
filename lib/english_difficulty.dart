import 'package:flutter/material.dart';
import 'main.dart';
import 'english_easy.dart'; // ✅ Import the Easy page
import 'package:flutter_svg/flutter_svg.dart';

class EnglishDifficulty extends StatelessWidget {
  const EnglishDifficulty({super.key});

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
                          'assets/englishdifficulty.svg',
                          fit: BoxFit.cover, // This fills the screen while keeping the ratio
                        ),
                      ),

                      // ✅ Back Button
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
                                builder: (context) => const MyApp(),
                              ),
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
                                builder: (context) => const EnglishEasy(),
                              ),
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
                                builder: (context) => const MyApp(),
                              ),
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
                                builder: (context) => const MyApp(),
                              ),
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
