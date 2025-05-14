import 'package:flutter/material.dart';
import 'main.dart'; // This should expose `backgroundAudioPlayer`
import 'package:flutter_svg/flutter_svg.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
  double volume = 0.5;
  bool sfxEnabled = true;

  @override
  void initState() {
    super.initState();
    backgroundAudioPlayer.setVolume(volume);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;
          double aspectRatio = 448 / 207;
          double scaledHeight = screenWidth / aspectRatio;

          return Center(
            child: SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: FittedBox(
                fit: BoxFit.fill,
                child: SizedBox(
                  width: screenWidth,
                  height: scaledHeight,
                  child: Stack(
                    children: [
                      // ✅ Background
                      Positioned.fill(
                        child: SvgPicture.asset(
                          'assets/settings.svg',
                          fit: BoxFit.cover,
                        ),
                      ),

                      // ✅ Back Button
                      Positioned(
                        left: screenWidth * 0.04,
                        top: scaledHeight * 0.585,
                        width: screenWidth * 0.23,
                        height: scaledHeight * 0.15,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyApp(),
                              ),
                            );
                          },
                          child: Transform.rotate(
                            angle: -0.15,
                            child: Container(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                      ),

                      // ✅ Volume Slider — scaled properly now
                      Positioned(
                        left: screenWidth * 0.34,
                        top: scaledHeight * 0.59,
                        width: screenWidth * 0.3,
                        height: scaledHeight * 0.08,
                        child: Slider(
                          value: volume,
                          onChanged: (newValue) {
                            setState(() {
                              volume = newValue;
                            });
                            backgroundAudioPlayer.setVolume(volume);
                          },
                          min: 0,
                          max: 1,
                          activeColor: Colors.blueAccent,
                          inactiveColor: Colors.grey.shade400,
                        ),
                      ),

                      // ✅ SFX Switch — scaled properly now
                      Positioned(
                        left: screenWidth * 0.80,
                        top: scaledHeight * 0.61,
                        width: screenWidth * 0.10,
                        height: scaledHeight * 0.2,
                        child: Transform.rotate(
                          angle: -0.10,
                          child: Switch(
                            value: sfxEnabled,
                            onChanged: (value) {
                              setState(() {
                                sfxEnabled = value;
                              });
                              // You can add logic here to toggle SFX
                            },
                            activeColor: Colors.green,
                            inactiveThumbColor: Colors.red,
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
