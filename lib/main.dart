import 'package:flutter/material.dart';
import 'settings.dart';
import 'subjects.dart';
import 'credits.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:audioplayers/audioplayers.dart';

final AudioPlayer backgroundAudioPlayer = AudioPlayer();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const BackgroundScreen(),
    );
  }
}

class BackgroundScreen extends StatefulWidget {
  const BackgroundScreen({super.key});

  @override
  State<BackgroundScreen> createState() => _BackgroundScreenState();
}

class _BackgroundScreenState extends State<BackgroundScreen> {
  // Audio player instance
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _playBackgroundMusic();
  }

  @override
  void dispose() {
    _audioPlayer.stop();  // Stop the music when the screen is disposed
    _audioPlayer.dispose();  // Dispose the player to release resources
    super.dispose();
  }

  // Method to play background music
  // Method to play background music
// Method to play background music
void _playBackgroundMusic() async {
  await backgroundAudioPlayer.setReleaseMode(ReleaseMode.LOOP);
  await backgroundAudioPlayer.play('assets/music/music.mp3', isLocal: true);
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;
          double aspectRatio = 448 / 207; // Set this to match your actual image aspect ratio

          return Center(
            child: SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: FittedBox(
                fit: BoxFit.fill, // Makes sure it expands to fill the screen
                child: SizedBox(
                  width: screenWidth,
                  height: screenWidth / aspectRatio, // Maintain image aspect ratio
                  child: Stack(
                    children: [
                      // ✅ Background Image (Expands to fit)
                      Positioned.fill(
                        child: SvgPicture.asset(
                          'assets/home.svg',
                          fit: BoxFit.cover, // This fills the screen while keeping the ratio
                        ),
                      ),

                      // ✅ Play Button
                      Positioned(
                        left: screenWidth * 0.11,
                        top: (screenWidth / aspectRatio) * 0.29,
                        width: screenWidth * 0.25,
                        height: (screenWidth / aspectRatio) * 0.1,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SubjectsPage(),
                              ),
                            );
                          },
                          child: Transform.rotate(
                            angle: -0.1,
                            child: Container(
                              color: Colors.red.withOpacity(0.0),
                            ),
                          ),
                        ),
                      ),

                      // ✅ Settings Button
                      Positioned(
                        left: screenWidth * 0.075,
                        top: (screenWidth / aspectRatio) * 0.45,
                        width: screenWidth * 0.265,
                        height: (screenWidth / aspectRatio) * 0.1,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SettingsPage(),
                              ),
                            );
                          },
                          child: Transform.rotate(
                            angle: -0.05,
                            child: Container(
                              color: Colors.blue.withOpacity(0.0),
                            ),
                          ),
                        ),
                      ),

                      // ✅ Credits Button
                      Positioned(
                        left: screenWidth * 0.09,
                        top: (screenWidth / aspectRatio) * 0.6,
                        width: screenWidth * 0.262,
                        height: (screenWidth / aspectRatio) * 0.10,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CreditsPage(),
                              ),
                            );
                          },
                          child: Transform.rotate(
                            angle: 0,
                            child: Container(
                              color: Colors.green.withOpacity(0.0),
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
