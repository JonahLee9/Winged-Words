import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final volumeProvider = StateProvider<double>((ref) => 0.5);
final sfxProvider = StateProvider<bool>((ref) => true);

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double volume = ref.watch(volumeProvider);
    final bool sfxEnabled = ref.watch(sfxProvider);

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/settings_background.png', // Ensure this asset exists in pubspec.yaml
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                const Text(
                  "Settings",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 20),
                const Text(
                  "VOLUME",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Slider(
                  value: volume,
                  onChanged: (value) => ref.read(volumeProvider.notifier).update((state) => value),
                  min: 0,
                  max: 1,
                  activeColor: Colors.white,
                ),
                const Icon(Icons.volume_up, color: Colors.white, size: 30),
                const SizedBox(height: 30),
                const Text(
                  "SFX",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Switch(
                  value: sfxEnabled,
                  onChanged: (value) => ref.read(sfxProvider.notifier).update((state) => value),
                  activeColor: Colors.green,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.brown,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  ),
                  child: const Text(
                    "Back",
                    style: TextStyle(fontSize: 25),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
