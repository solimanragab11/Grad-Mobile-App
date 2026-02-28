import 'package:flutter/material.dart';

class TranscribedTextWidget extends StatelessWidget {
  const TranscribedTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.2,
      width: size.width * 0.95,
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: const Center(
        child: Text(
          "Transcribed text will appear here",
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }
}
