import 'package:flutter/material.dart';

class CreditsPage extends StatelessWidget {
  const CreditsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://media.istockphoto.com/id/1344646630/vector/summer-forest-landscape-swampy-coast-with-cattails-and-reed-flat-style-quiet-river-or-lake.jpg?s=1024x1024&w=is&k=20&c=npKkdkMtQABmnKFHppY1Eh5wFTSEYIX9Wwg9yReWqAY=',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Content
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.85),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Header
                    const Text(
                      'Credits',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF009624),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Developers & Designers Section
                    CreditsSection(
                      title: 'Developers & Designers',
                      items: const ['Lyam Arencibia-Herrera', 'Jonah Lee', 'Eduardo Ramos'],
                    ),

                    // Special Thanks Section
                    CreditsSection(
                      title: 'Special Thanks',
                      items: const ['Mr. Davisson'],
                    ),

                    // About Us Section
                    AboutUsSection(),

                    // Footer
                    const SizedBox(height: 20),
                    Footer(),
                  ],
                ),
              ),
            ),
          ),

          // Back Button
          Positioned(
            top: 20,
            right: 20,
            child: BackButtonWidget(),
          ),
        ],
      ),
    );
  }
}

class CreditsSection extends StatelessWidget {
  final String title;
  final List<String> items;

  const CreditsSection({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF009624),
          ),
        ),
        const SizedBox(height: 10),
        ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                item,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            )),
        const SizedBox(height: 20),
      ],
    );
  }
}

class AboutUsSection extends StatelessWidget {
  const AboutUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'About Us',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF009624),
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Atech Students',
          style: TextStyle(fontSize: 16, color: Colors.white, height: 1.5),
        ),
      ],
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          '© 2024 Winged Words & Equations',
          style: TextStyle(fontSize: 14, color: Color(0xFF66FF66)),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 5),
        Text(
          'Image credit: Ivan Mordvinkin',
          style: TextStyle(fontSize: 14, color: Color(0xFF66FF66)),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.brown,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: const Text(
        'Back',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
