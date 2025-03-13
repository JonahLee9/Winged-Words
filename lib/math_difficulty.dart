import 'package:flutter/material.dart';

class MathDifficulty extends StatelessWidget {
  const MathDifficulty({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Text(
                  'MATH',
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
                Column(
                  children: [
                    _buildDifficultyButton(
                      context,
                      'Easy Mode',
                      Colors.green,
                      '/MathEasy',
                    ),
                    const SizedBox(height: 20),
                    _buildDifficultyButton(
                      context,
                      'Medium Mode',
                      Colors.green,
                      '/MathMedium',
                    ),
                    const SizedBox(height: 20),
                    _buildDifficultyButton(
                      context,
                      'Hard Mode',
                      Colors.green,
                      '/MathHard',
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildBackButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDifficultyButton(
      BuildContext context, String label, Color color, String route) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
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
        Navigator.pushNamed(context, route);
      },
      child: Text(label),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
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
        Navigator.pop(context);
      },
      child: const Text('Back'),
    );
  }
}