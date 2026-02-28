import 'package:flutter/material.dart';

class AudioPlayerWidget extends StatelessWidget {
  const AudioPlayerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Container(
      width: w,
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F7FF), // لون خلفية سماوي فاتح جداً
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // زرار الـ Play
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFF3498DB), // اللون الأزرق
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),

          // شكل الـ Waveform
          CustomPaint(size: const Size(80, 30), painter: WaveformPainter()),

          const SizedBox(width: 12),

          // النقطة الزرقاء (Progress indicator)
          const Icon(Icons.circle, color: Color(0xFF3498DB), size: 12),

          const SizedBox(width: 12),

          // الوقت
          const Text(
            "0:15 / :30",
            style: TextStyle(
              color: Color(0xFF555555),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// الـ Painter المسؤول عن رسم الموجات الصوتية
class WaveformPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF3498DB).withOpacity(0.4)
      ..style = PaintingStyle.fill
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    // ارتفاعات عشوائية للموجات زي الصورة
    final heights = [0.3, 0.5, 0.8, 0.6, 0.9, 0.7, 0.4, 0.6, 0.8, 0.5];
    final double gap = size.width / (heights.length - 1);

    for (int i = 0; i < heights.length; i++) {
      double x = i * gap;
      double h = size.height * heights[i];
      double top = (size.height - h) / 2;

      // تغيير لون النص الأول من الموجات ليكون أغمق (كأنه الجزء اللي اشتغل)
      if (i < 4) {
        paint.color = const Color(0xFF3498DB);
      } else {
        paint.color = const Color(0xFF3498DB).withOpacity(0.3);
      }

      canvas.drawLine(Offset(x, top), Offset(x, top + h), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
