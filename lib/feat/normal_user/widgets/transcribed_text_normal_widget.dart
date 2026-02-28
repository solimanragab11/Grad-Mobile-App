import 'package:flutter/material.dart';

class TranscribedTextNormalWidget extends StatelessWidget {
  const TranscribedTextNormalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.7,
      width: size.width * 0.9,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: const Text(
          "Transcribed text will appear here.",
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
    );
  }
}
