import 'package:flutter/material.dart';
import 'main.dart';

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
                        child: Image.asset(
                          'assets/mathdifficulty.png',
                          fit: BoxFit.cover, // This fills the screen while keeping the ratio
                        ),
                      ),

                      //✅Back Button
                      Positioned(
                        left: screenWidth * 0.01,
                        top: (screenWidth / aspectRatio) * 0.06,
                        width: screenWidth * 0.11,
                        height: (screenWidth / aspectRatio) * 0.13,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyApp()),
                            );
                          },
                          child: Transform.rotate(
                            angle: -0.23,
                            child: Container(
                              color: Colors.red.withOpacity(0.3),
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
                                  builder: (context) => const MyApp()),
                            );
                          },
                          child: Transform.rotate(
                            angle: 0.0,
                            child: Container(
                              color: Colors.red.withOpacity(0.3),
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
                                  builder: (context) => const MyApp()),
                            );
                          },
                          child: Transform.rotate(
                            angle: 0.0,
                            child: Container(
                              color: Colors.red.withOpacity(0.3),
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
                                  builder: (context) => const MyApp()),
                            );
                          },
                          child: Transform.rotate(
                            angle: 0.0,
                            child: Container(
                              color: Colors.red.withOpacity(0.3),
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
