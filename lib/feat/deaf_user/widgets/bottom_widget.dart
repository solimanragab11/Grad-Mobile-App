import 'package:flutter/material.dart';

class VoiceControlPanel extends StatelessWidget {
  // تعريف الـ Actions عشان تقدر تنفذ وظائف حقيقية
  final VoidCallback? onSpeedTap;
  final VoidCallback? onPauseTap;
  final VoidCallback? onMicTap;
  final VoidCallback? onPlayTap;
  final VoidCallback? onShareTap;

  const VoiceControlPanel({
    super.key,
    this.onSpeedTap,
    this.onPauseTap,
    this.onMicTap,
    this.onPlayTap,
    this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      // ضفنا Material عشان تأثير الـ Ripple يبان
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
            IconButton(
              icon: const Icon(Icons.speed, color: Colors.black54),
              onPressed: onSpeedTap,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey[100]),
                shape: MaterialStateProperty.all(const CircleBorder()),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.pause, color: Colors.black54),
              onPressed: onPauseTap,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey[100]),
                shape: MaterialStateProperty.all(const CircleBorder()),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.mic, color: Colors.white),
              onPressed: onMicTap,
              iconSize: 52,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                shape: MaterialStateProperty.all(const CircleBorder()),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.play_arrow, color: Colors.black54),
              onPressed: onPlayTap,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey[100]),
                shape: MaterialStateProperty.all(const CircleBorder()),
              ),
            ),
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
