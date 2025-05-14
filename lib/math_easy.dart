import 'dart:math';
import 'package:flutter/material.dart';
import 'math_difficulty.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MathEasy extends StatelessWidget {
  const MathEasy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BackgroundScreen(),
    );
  }
}

// 🐦 Oscillating Bird Widget (Responsive to Resizing)
class OscillatingBird extends StatefulWidget {
  final String imagePath;
  final double top;
  final double width;
  final double height;
  final double screenWidth;
  final int solution;
  final void Function(int) onTap;

  const OscillatingBird({
    super.key,
    required this.imagePath,
    required this.top,
    required this.width,
    required this.height,
    required this.screenWidth,
    required this.solution,
    required this.onTap,
  });

  @override
  State<OscillatingBird> createState() => _OscillatingBirdState();
}

class _OscillatingBirdState extends State<OscillatingBird>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    final random = Random();
    double startValue = random.nextDouble();

    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..forward(from: startValue)
     ..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        double startLeft = widget.screenWidth * 0.0335;
        double endLeft = widget.screenWidth * 0.9;
        double currentLeft = startLeft + (endLeft - startLeft) * _animation.value;

        return Positioned(
          left: currentLeft,
          top: widget.top,
          width: widget.width,
          height: widget.height,
          child: GestureDetector(
            onTap: () => widget.onTap(widget.solution),
            child: Stack(
              children: [
                Image.asset(
                  widget.imagePath,
                  fit: BoxFit.contain,
                ),
                Positioned(
                  bottom: widget.height * 0.1,
                  left: widget.width * 0.15,
                  child: Text(
                    widget.solution.toString(),
                    style: TextStyle(
                      fontSize: widget.width * 0.15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'Pangolin',
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BackgroundScreen extends StatefulWidget {
  const BackgroundScreen({super.key});

  @override
  State<BackgroundScreen> createState() => _BackgroundScreenState();
}

class _BackgroundScreenState extends State<BackgroundScreen> {
  late String equation;
  late int correctAnswer;
  late List<int> options;
  int score = 0;

  @override
  void initState() {
    super.initState();
    generateEquationAndAnswers();
  }

  void generateEquationAndAnswers() {
    final random = Random();
    final operations = ['+', '-', '*', '/'];
    final op = operations[random.nextInt(operations.length)];

    int a, b;

    switch (op) {
      case '+':
        a = random.nextInt(100);
        b = random.nextInt(100);
        correctAnswer = a + b;
        break;
      case '-':
        a = random.nextInt(100);
        b = random.nextInt(100);
        if (b > a) {
          final temp = a;
          a = b;
          b = temp;
        }
        correctAnswer = a - b;
        break;
      case '*':
        a = random.nextInt(20);
        b = random.nextInt(10);
        correctAnswer = a * b;
        break;
      case '/':
        b = random.nextInt(9) + 1;
        int result = random.nextInt(10);
        a = b * result;
        correctAnswer = result;
        break;
      default:
        a = b = correctAnswer = 0;
    }

    equation = '$a $op $b =';

    final incorrect = <int>{};
    while (incorrect.length < 3) {
      int wrong = correctAnswer + random.nextInt(21) - 10;
      if (wrong != correctAnswer && wrong >= 0) {
        incorrect.add(wrong);
      }
    }

    options = [...incorrect, correctAnswer]..shuffle();
  }

  void handleAnswerTap(int selectedAnswer) {
    if (selectedAnswer == correctAnswer) {
      setState(() {
        score += 1;
        generateEquationAndAnswers();
      });
    } else {
      setState(() {
        if (score > 0) {
          score -= 1;
        }
        generateEquationAndAnswers();
      });
    }

    if (score == 20) {
      _showWinDialog(context);
    }
  }

  void _showWinDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("You won!"),
          content: const Text("Congratulations! You've Won!"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void resetGame() {
    setState(() {
      score = 0;
      generateEquationAndAnswers();
    });
  }

  List<Widget> generateBirds(double screenWidth, double aspectRatio) {
    double birdWidth = screenWidth * 0.18;
    double birdHeight = (screenWidth / aspectRatio) * 0.20;
    double verticalSpacing = (screenWidth / aspectRatio) * 0.2;

    List<Widget> birds = [];

    for (int i = 0; i < options.length; i++) {
      double top = (screenWidth / aspectRatio) * 0.215 + (i * verticalSpacing);

      birds.add(
        OscillatingBird(
          imagePath: 'assets/birdsign.png',
          top: top,
          width: birdWidth,
          height: birdHeight,
          screenWidth: screenWidth,
          solution: options[i],
          onTap: handleAnswerTap,
        ),
      );
    }

    return birds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;
          double aspectRatio = 448 / 207;

          double eqBoxWidth = screenWidth * 0.15;
          double eqBoxHeight = (screenWidth / aspectRatio) * 0.08;
          double eqFontSize = screenWidth * 0.02;

          return Center(
            child: SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: FittedBox(
                fit: BoxFit.fill,
                child: SizedBox(
                  width: screenWidth,
                  height: screenWidth / aspectRatio,
                  child: Stack(
                    children: [
                      // ✅ Background Image
                      Positioned.fill(
                        child: SvgPicture.asset(
                          'assets/mathpage.svg',
                          fit: BoxFit.cover,
                        ),
                      ),

                      // ✅ Equation Display at Top Center
                      Positioned(
                        left: screenWidth / 2 - eqBoxWidth / 2,
                        top: (screenWidth / aspectRatio) * 0.135,
                        width: eqBoxWidth,
                        height: eqBoxHeight,
                        child: Center(
                          child: Text(
                            '$equation',
                            style: TextStyle(
                              fontSize: eqFontSize,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Pangolin',
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),

                      // ✅ Score Display in Upper Right
                      Positioned(
                        left: screenWidth * 0.82,
                        top: (screenWidth / aspectRatio) * 0.028,
                        child: Text(
                          'Score: $score',
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: 'Pangolin',
                          ),
                        ),
                      ),

                      // ✅ Oscillating Birds with solutions
                      ...generateBirds(screenWidth, aspectRatio),

                      // ✅ Back Button
                      Positioned(
                        left: screenWidth * 0.03,
                        top: (screenWidth / aspectRatio) * 0.045,
                        width: screenWidth * 0.125,
                        height: (screenWidth / aspectRatio) * 0.135,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MathDifficulty(),
                              ),
                            );
                          },
                          child: Transform.rotate(
                            angle: -0.28,
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
