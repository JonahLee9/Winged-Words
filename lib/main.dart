import 'package:flutter/material.dart';

void main() {
  runApp(EducationGameApp());
}

class EducationGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Education Game',
      theme: ThemeData(
        fontFamily: 'Baloo2',
      ),
      home: MenuPage(),
    );
  }
}

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Winged Words \n & Equations',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              SizedBox(height: 20),
              MenuButton(
                icon: Icons.play_arrow,
                text: 'Play',
                onPressed: () {
                  // Navigate to SubjectsPage
                },
              ),
              MenuButton(
                icon: Icons.settings,
                text: 'Settings',
                onPressed: () {
                  // Navigate to SettingsPage
                },
              ),
              MenuButton(
                icon: Icons.info,
                text: 'Credits',
                onPressed: () {
                  // Navigate to CreditsPage
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  MenuButton({required this.icon, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 25),
      label: Text(
        text,
        style: TextStyle(fontSize: 22),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
