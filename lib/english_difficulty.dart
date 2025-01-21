import 'package:flutter/material.dart';

class EnglishDifficulty extends StatelessWidget {
  const EnglishDifficulty({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a Stack to add a fixed background image and overlay content
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://st2.depositphotos.com/1526816/11268/v/450/depositphotos_112683892-stock-illustration-scene-with-many-toucans-flying.jpg'),
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
          // Page Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Large Title
                Text(
                  'ENGLISH',
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 6.0,
                        color: Colors.black.withOpacity(0.7),
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Subheading
                Text(
                  'Select\nDifficulty',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                    shadows: [
                      Shadow(
                        blurRadius: 4.0,
                        color: Colors.black.withOpacity(0.7),
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                // Difficulty Buttons
                Column(
                  children: [
                    _buildDifficultyButton(
                      context,
                      'Easy Mode',
                      Colors.green,
                      '/EnglishEasy',
                    ),
                    const SizedBox(height: 20),
                    _buildDifficultyButton(
                      context,
                      'Medium Mode',
                      Colors.green,
                      '/EnglishMedium',
                    ),
                    const SizedBox(height: 20),
                    _buildDifficultyButton(
                      context,
                      'Hard Mode',
                      Colors.green,
                      '/EnglishHard',
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Back Button
                _buildBackButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to create difficulty buttons
  Widget _buildDifficultyButton(
      BuildContext context, String label, Color color, String route) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // Updated from `primary`
        foregroundColor: Colors.white, // Updated from `onPrimary`
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        textStyle: const TextStyle(
          fontSize: 18,
          fontFamily: 'Baloo2',
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, route); // Navigate to the specific route
      },
      child: Text(label),
    );
  }

  // Helper function to create the back button
  Widget _buildBackButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red, // Updated from `primary`
        foregroundColor: Colors.white, // Updated from `onPrimary`
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        textStyle: const TextStyle(
          fontSize: 18,
          fontFamily: 'Baloo2',
        ),
      ),
      onPressed: () {
        Navigator.pop(context); // Navigate back to the previous page
      },
      child: const Text('Back'),
    );
  }
}
