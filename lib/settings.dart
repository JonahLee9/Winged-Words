import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isMusicEnabled = false;
  bool isSfxEnabled = true;
  double volume = 0.5;
  late AudioPlayer musicPlayer;
  late AudioPlayer buttonPlayer;

  @override
  void initState() {
    super.initState();
    musicPlayer = AudioPlayer();
    buttonPlayer = AudioPlayer();
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isMusicEnabled = prefs.getBool('musicEnabled') ?? false;
      isSfxEnabled = prefs.getBool('sfxEnabled') ?? true;
      volume = prefs.getDouble('musicVolume') ?? 0.5;
    });
    if (isMusicEnabled) {
      await musicPlayer.setSourceUrl(
          'https://www.dropbox.com/scl/fi/g5sreszvsrab6kdyof48y/Sunset-Samba-1.mp3?rlkey=6k8tkwi3cahp7wihm0bbhgz5m&st=p5bals5a&raw=1');
      await musicPlayer.setVolume(volume);
      await musicPlayer.resume();
    }
  }

  Future<void> savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('musicEnabled', isMusicEnabled);
    prefs.setBool('sfxEnabled', isSfxEnabled);
    prefs.setDouble('musicVolume', volume);
  }

  @override
  void dispose() {
    musicPlayer.dispose();
    buttonPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://media.istockphoto.com/id/1344646630/vector/summer-forest-landscape-swampy-coast-with-cattails-and-reed-flat-style-quiet-river-or-lake.jpg?s=1024x1024&w=is&k=20&c=npKkdkMtQABmnKFHppY1Eh5wFTSEYIX9Wwg9yReWqAY='),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              settingsContainer(
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isMusicEnabled ? Colors.green : Colors.red,
                      ),
                      onPressed: () async {
                        setState(() {
                          isMusicEnabled = !isMusicEnabled;
                        });
                        if (isMusicEnabled) {
                          await musicPlayer.setSourceUrl(
                              'https://www.dropbox.com/scl/fi/g5sreszvsrab6kdyof48y/Sunset-Samba-1.mp3?rlkey=6k8tkwi3cahp7wihm0bbhgz5m&st=p5bals5a&raw=1');
                          await musicPlayer.setVolume(volume);
                          await musicPlayer.resume();
                        } else {
                          await musicPlayer.pause();
                        }
                        savePreferences();
                      },
                      child: Text(
                        isMusicEnabled ? 'Turn Music Off' : 'Turn Music On',
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('0'),
                        Slider(
                          value: volume,
                          min: 0,
                          max: 1,
                          onChanged: (newVolume) async {
                            setState(() {
                              volume = newVolume;
                            });
                            await musicPlayer.setVolume(volume);
                            savePreferences();
                          },
                        ),
                        Text('100'),
                      ],
                    ),
                    Text('Volume: ${(volume * 100).toInt()}%'),
                  ],
                ),
              ),
              settingsContainer(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('SFX'),
                        Switch(
                          value: isSfxEnabled,
                          onChanged: (value) {
                            setState(() {
                              isSfxEnabled = value;
                              if (isSfxEnabled) {
                                buttonPlayer.play(UrlSource(
                                    'https://www.dropbox.com/scl/fi/u52y5ra4inx16jsp521ul/click-buttons-ui-menu-sounds-effects-button-7-203601.mp3?rlkey=shlabmmrayjdes7ytyj1t048i&st=q7zzwu4o&raw=1'));
                              }
                              savePreferences();
                            });
                          },
                        ),
                      ],
                    ),
                    Text('Sound Effects: ${isSfxEnabled ? 'Enabled' : 'Disabled'}'),
                  ],
                ),
              ),
              backButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget settingsContainer({required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.85),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget backButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text('Back'),
    );
  }
}
