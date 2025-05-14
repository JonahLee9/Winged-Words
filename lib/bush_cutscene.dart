/*
import 'package:flutter/material.dart';

class BushCutscene extends StatefulWidget {
  final Widget nextPage;
  const BushCutscene({required this.nextPage, super.key});

  @override
  State<BushCutscene> createState() => _BushCutsceneState();
}

class _BushCutsceneState extends State<BushCutscene> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _leftBush;
  late Animation<Offset> _rightBush;
  bool _showNext = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _leftBush = Tween<Offset>(
      begin: Offset(-1.2, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _rightBush = Tween<Offset>(
      begin: Offset(1.2, 0.0),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _startCutscene();
  }

  void _startCutscene() async {
    await _controller.forward();
    await Future.delayed(Duration(milliseconds: 300));
    setState(() => _showNext = true);
    await Future.delayed(Duration(milliseconds: 400));
    await _controller.reverse();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => widget.nextPage,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _showNext
            ? widget.nextPage
            : Container(color: Colors.transparent), // Empty while bushes animate in

        // Left bush
        SlideTransition(
          position: _leftBush,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Transform.rotate(
              angle: -1.5708,
              child: Image.asset(
                'assets/bush.png',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        // Right bush
        SlideTransition(
          position: _rightBush,
          child: Align(
            alignment: Alignment.centerRight,
            child: Transform.rotate(
              angle: 1.5708,
              child: Image.asset(
                'assets/bush.png',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
*/
