import 'package:flutter/material.dart';

class VoiceControlPanel extends StatelessWidget {
  final String speedLabel;
  final bool isPlaying;

  final VoidCallback onSpeedTap;
  final VoidCallback onPauseTap;   // keep as is
  final VoidCallback onMicTap;     // mic listen/stop
  final VoidCallback onReplayTap;  // play button becomes replay
  final VoidCallback onShareTap;   // real share

  const VoiceControlPanel({
    super.key,
    required this.speedLabel,
    required this.isPlaying,
    required this.onSpeedTap,
    required this.onPauseTap,
    required this.onMicTap,
    required this.onReplayTap,
    required this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Speed -> opens picker
            IconButton(
              onPressed: onSpeedTap,
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.speed, color: Colors.black54),
                  Text(
                    speedLabel,
                    style: const TextStyle(fontSize: 10, color: Colors.black54),
                  ),
                ],
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey[100]),
                shape: MaterialStateProperty.all(const CircleBorder()),
              ),
            ),

            // Pause/Resume toggle (unchanged)
            IconButton(
              onPressed: onPauseTap,
              icon: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.black54,
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey[100]),
                shape: MaterialStateProperty.all(const CircleBorder()),
              ),
            ),

            // Mic (audio input)
            IconButton(
              icon: const Icon(Icons.mic, color: Colors.white),
              onPressed: onMicTap,
              iconSize: 52,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                shape: MaterialStateProperty.all(const CircleBorder()),
              ),
            ),

            // Play button becomes Replay
            IconButton(
              icon: const Icon(Icons.replay, color: Colors.black54),
              onPressed: onReplayTap,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey[100]),
                shape: MaterialStateProperty.all(const CircleBorder()),
              ),
            ),

            // Real share
            IconButton(
              icon: const Icon(Icons.share, color: Colors.black54),
              onPressed: onShareTap,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey[100]),
                shape: MaterialStateProperty.all(const CircleBorder()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}