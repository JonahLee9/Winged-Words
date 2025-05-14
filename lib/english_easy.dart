import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EnglishEasy extends StatelessWidget {
  const EnglishEasy({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EnglishEasyGame(),
    );
  }
}

class EnglishEasyGame extends StatefulWidget {
  const EnglishEasyGame({super.key});

  @override
  State<EnglishEasyGame> createState() => _EnglishEasyGameState();
}

class _EnglishEasyGameState extends State<EnglishEasyGame>
    with TickerProviderStateMixin {
  final List<String> alphabet = List.generate(26, (i) => String.fromCharCode(65 + i));
  int currentIndex = 0;
  int score = 0;
  late List<String> options;
  final Random random = Random();
  final List<AnimationController> controllers = [];
  final List<Animation<double>> animations = [];

  @override
  void initState() {
    super.initState();
    generateOptions();
    setupAnimations();
  }

  void setupAnimations() {
    // Dispose previous ones
    for (var c in controllers) {
      c.dispose();
    }
    controllers.clear();
    animations.clear();

    for (int i = 0; i < 4; i++) {
      final controller = AnimationController(
        duration: Duration(seconds: 3 + random.nextInt(3)), // 3 to 5 seconds
        vsync: this,
      )..repeat(reverse: true);
      final animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );
      controllers.add(controller);
      animations.add(animation);
    }
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void generateOptions() {
    final correctLetter = alphabet[currentIndex];
    final Set<String> optionSet = {correctLetter};

    while (optionSet.length < 4) {
      final char = String.fromCharCode(65 + random.nextInt(26));
      optionSet.add(char);
    }

    options = optionSet.toList()..shuffle();
  }

  void handleAnswerTap(String selected) {
    if (selected == alphabet[currentIndex]) {
      setState(() {
        currentIndex++;
        score++;
        if (currentIndex < alphabet.length) {
          generateOptions();
          setupAnimations();
        }
      });

      if (currentIndex == alphabet.length) {
        _showWinDialog();
      }
    } else {
      setState(() {
        if (score > 0) score--;
      });
    }
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("You won!"),
        content: const Text("Congratulations! You've finished the alphabet!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              resetGame();
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void resetGame() {
    setState(() {
      currentIndex = 0;
      score = 0;
      generateOptions();
      setupAnimations();
    });
  }

  List<Widget> generateBirds(double width, double height) {
    double birdWidth = width * 0.18;
    double birdHeight = height * 0.15;
    double spacing = height * 0.2;

    List<Widget> birds = [];

    for (int i = 0; i < options.length; i++) {
      double top = height * 0.25 + i * spacing;
      double startLeft = width * 0.05;
      double endLeft = width * 0.8;

      birds.add(
        AnimatedBuilder(
          animation: animations[i],
          builder: (context, child) {
            double left = startLeft + (endLeft - startLeft) * animations[i].value;
            return Positioned(
              top: top,
              left: left,
              width: birdWidth,
              height: birdHeight,
              child: GestureDetector(
                onTap: () => handleAnswerTap(options[i]),
                child: Stack(
                  children: [
                    Image.asset('assets/birdsign.png', fit: BoxFit.contain),
                    Positioned(
                      bottom: birdHeight * 0.1,
                      left: birdWidth * 0.25,
                      child: Text(
                        options[i],
                        style: TextStyle(
                          fontSize: birdWidth * 0.15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pangolin',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }

    return birds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;

        return Stack(
          children: [
            // Background
            Positioned.fill(
              child: SvgPicture.asset('assets/mathpage.svg', fit: BoxFit.cover),
            ),

            // Back button (cloud-shaped design)
            Positioned(
              top: height * 0.03,
              left: width * 0.03,
              child: GestureDetector(
                onTap: () => Navigator.of(context).popUntil((route) => route.isFirst),
                child: Image.asset(
                  'assets/back_button_cloud.png',  // Replace with the exact image file you uploaded
                  width: width * 0.15,
                  height: height * 0.1,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Prompt
            Positioned(
              top: height * 0.08,
              left: width * 0.1,
              right: width * 0.1,
              child: Center(
                child: Text(
                  currentIndex == 0
                      ? 'Select the first letter of the alphabet!'
                      : currentIndex < alphabet.length
                          ? 'Select the letter after ${alphabet[currentIndex - 1]}'
                          : '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pangolin',
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            // Score
            Positioned(
              top: height * 0.03,
              right: width * 0.05,
              child: Text(
                'Score: $score',
                style: TextStyle(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Pangolin',
                  color: Colors.black,
                ),
              ),
            ),

            // Birds
            ...generateBirds(width, height),
          ],
        );
      }),
    );
  }
}
