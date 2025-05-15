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
  final List<String> alphabet =
      List.generate(26, (i) => String.fromCharCode(65 + i));
  int currentIndex = 0;
  int score = 0;
  late List<String> options;
  final Random random = Random();

  final List<AnimationController> controllers = [];
  final List<Animation<double>> animations = [];

  late AnimationController zoomController;
  late Animation<double> zoomAnimation;
  late Animation<double> fadeAnimation;

  bool isAnimatingCorrect = false;
  String correctTappedLetter = '';

  @override
  void initState() {
    super.initState();
    generateOptions();
    setupAnimations();
    setupZoomAnimations();
  }

  void setupAnimations() {
    for (var c in controllers) {
      c.dispose();
    }
    controllers.clear();
    animations.clear();

    for (int i = 0; i < 4; i++) {
      final duration = Duration(milliseconds: 4000 + random.nextInt(2000));
      final controller = AnimationController(
        duration: duration,
        vsync: this,
      )..repeat(reverse: true);

      final animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );

      controllers.add(controller);
      animations.add(animation);
    }
  }

  void setupZoomAnimations() {
    zoomController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    zoomAnimation = Tween<double>(begin: 1.0, end: 2.5).animate(
      CurvedAnimation(parent: zoomController, curve: Curves.easeOut),
    );

    fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
          parent: zoomController,
          curve: const Interval(0.6, 1.0, curve: Curves.easeOut)),
    );

    zoomController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isAnimatingCorrect = false;
          currentIndex++;
          if (currentIndex < alphabet.length) {
            generateOptions();
            setupAnimations();
          } else {
            _showWinDialog();
          }
        });
        zoomController.reset();
      }
    });
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    zoomController.dispose();
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
    if (isAnimatingCorrect) return;

    if (selected == alphabet[currentIndex]) {
      setState(() {
        isAnimatingCorrect = true;
        correctTappedLetter = selected;
        score++;
      });
      zoomController.forward();
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
      isAnimatingCorrect = false;
      zoomController.reset();
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

      bool isCorrect = (options[i] == alphabet[currentIndex]);

      birds.add(
        AnimatedBuilder(
          animation: animations[i],
          builder: (context, child) {
            double left = startLeft + (endLeft - startLeft) * animations[i].value;

            if (isAnimatingCorrect && options[i] == correctTappedLetter) {
              left = (width - birdWidth * zoomAnimation.value) / 2;
              top = (height - birdHeight * zoomAnimation.value) / 2;
            }

            return Positioned(
              top: top,
              left: left,
              width: isAnimatingCorrect && isCorrect
                  ? birdWidth * zoomAnimation.value
                  : birdWidth,
              height: isAnimatingCorrect && isCorrect
                  ? birdHeight * zoomAnimation.value
                  : birdHeight,
              child: GestureDetector(
                onTap: () {
                  if (!isAnimatingCorrect) {
                    handleAnswerTap(options[i]);
                  }
                },
                child: Stack(
                  children: [
                    Container(
                      decoration: isCorrect
                          ? BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage('assets/birdsign.png'),
                                fit: BoxFit.contain,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.green.withOpacity(0.7),
                                  blurRadius: 12,
                                  spreadRadius: 4,
                                ),
                              ],
                            )
                          : const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/birdsign.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                    ),
                    Positioned.fill(
                      child: FadeTransition(
                        opacity: isCorrect && isAnimatingCorrect
                            ? fadeAnimation
                            : const AlwaysStoppedAnimation(1),
                        child: Center(
                          child: Text(
                            options[i],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: birdWidth *
                                  (isAnimatingCorrect && isCorrect
                                      ? zoomAnimation.value * 0.25
                                      : 0.25),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Pangolin',
                              color: Colors.black,
                            ),
                          ),
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
            Positioned.fill(
              child: SvgPicture.asset('assets/mathpage.svg', fit: BoxFit.cover),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () => Navigator.of(context).popUntil((route) => route.isFirst),
                  child: Image.asset(
                    'assets/back_button_cloud.png',
                    width: width * 0.15,
                    height: height * 0.1,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
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
            ...generateBirds(width, height),
          ],
        );
      }),
    );
  }
}
