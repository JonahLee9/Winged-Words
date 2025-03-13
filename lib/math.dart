import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MathGameApp());
}

class MathGameApp extends StatelessWidget {
  const MathGameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DifficultySelectionScreen(),
    );
  }
}

class DifficultySelectionScreen extends StatelessWidget {
  const DifficultySelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Difficulty')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _startGame(context, 'Easy'),
              child: const Text('Easy'),
            ),
            ElevatedButton(
              onPressed: () => _startGame(context, 'Medium'),
              child: const Text('Medium'),
            ),
            ElevatedButton(
              onPressed: () => _startGame(context, 'Hard'),
              child: const Text('Hard'),
            ),
          ],
        ),
      ),
    );
  }

  void _startGame(BuildContext context, String difficulty) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MathGameScreen(difficulty: difficulty)),
    );
  }
}

class MathGameScreen extends StatefulWidget {
  final String difficulty;

  const MathGameScreen({super.key, required this.difficulty});

  @override
  _MathGameScreenState createState() => _MathGameScreenState();
}

class _MathGameScreenState extends State<MathGameScreen> {
  int score = 0;
  int correctAnswer = 0;
  String equation = '';
  Random random = Random();
  List<int> answerOptions = [];

  @override
  void initState() {
    super.initState();
    generateEquation();
  }

  void generateEquation() {
    int num1, num2, result;
    String operator;

    switch (widget.difficulty) {
      case 'Easy':
        num1 = random.nextInt(10) + 1;
        num2 = random.nextInt(10) + 1;
        operator = ['+', '-', '*'][random.nextInt(3)];
        break;
      case 'Medium':
        num1 = random.nextInt(20) + 1;
        num2 = random.nextInt(20) + 1;
        operator = ['+', '-', '*'][random.nextInt(3)];
        break;
      case 'Hard':
        num1 = random.nextInt(50) - 25;
        num2 = random.nextInt(50) - 25;
        operator = ['+', '-', '*'][random.nextInt(3)];
        break;
      default:
        return;
    }

    switch (operator) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '*':
        result = num1 * num2;
        break;
      default:
        return;
    }

    setState(() {
      correctAnswer = result;
      equation = '$num1 $operator $num2';
      generateAnswerOptions();
    });
  }

  void generateAnswerOptions() {
    Set<int> options = {correctAnswer};

    while (options.length < 4) {
      int wrongAnswer = correctAnswer + random.nextInt(10) - 5;
      if (wrongAnswer != correctAnswer) {
        options.add(wrongAnswer);
      }
    }

    setState(() {
      answerOptions = options.toList()..shuffle();
    });
  }

  void checkAnswer(int selectedAnswer) {
    setState(() {
      if (selectedAnswer == correctAnswer) {
        score++;
      } else {
        score--;
      }
      generateEquation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Math Game - ${widget.difficulty}')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Solve: $equation', style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: answerOptions.map((option) {
              return ElevatedButton(
                onPressed: () => checkAnswer(option),
                child: Text('$option'),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          Text('Score: $score', style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
