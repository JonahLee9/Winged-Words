import 'package:flutter/material.dart';
import 'credits.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Education Game',
      theme: ThemeData(fontFamily: 'Baloo 2'),
      home: const MenuPage(),
    );
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://t4.ftcdn.net/jpg/02/35/01/83/360_F_235018350_NwKA1B9koCLcptK9P1B4WznO19dIQPhe.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title Bar
              const Text(
                'Winged Words\n& Equations',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  height: 1.2, // Adjust spacing between lines
                ),
              ),
              const SizedBox(height: 40),

              // Menu Buttons
              Column(
                children: [
                  // Play Button
                  MenuButton(
                    text: 'Play',
                    iconUrl:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHrlx0XnBZ0SYe-N_V35TbZ2-tve-_wz4avQ&s',
                    onPressed: () {
                      // Navigate to Subjects Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PlaceholderPage('Subjects')),
                      );
                    },
                  ),
                  const SizedBox(height: 15),

                  // Settings Button
                  MenuButton(
                    text: 'Settings',
                    iconUrl:
                        'https://www.svgrepo.com/show/17716/gear.svg',
                    onPressed: () {
                      // Navigate to Settings Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PlaceholderPage('Settings')),
                      );
                    },
                  ),
                  const SizedBox(height: 15),

                  // Credits Button
                  MenuButton(
                    text: 'Credits',
                    iconUrl:
                        'https://png.pngtree.com/element_our/20190529/ourmid/pngtree-medical-drug-list-illustration-image_1217997.jpg',
                    onPressed: () {
                      // Navigate to Credits Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CreditsPage()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Menu Button Widget
class MenuButton extends StatelessWidget {
  final String text;
  final String iconUrl;
  final VoidCallback onPressed;

  const MenuButton({
    Key? key,
    required this.text,
    required this.iconUrl,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF28A745), // Updated property
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 3,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(
            iconUrl,
            width: 25,
            height: 25,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: const TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}


// Placeholder Page for Navigation
class PlaceholderPage extends StatelessWidget {
  final String title;

  const PlaceholderPage(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF28A745),
      ),
      body: Center(
        child: Text(
          '$title Page',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
