import 'package:flutter/material.dart';

class TranscribedTextWidget extends StatefulWidget {
  final ValueChanged<String> onTextChanged;
  final TextEditingController? controller;

  const TranscribedTextWidget({
    super.key,
    required this.onTextChanged,
    this.controller,
  });

  @override
  State<TranscribedTextWidget> createState() => _TranscribedTextWidgetState();
}

class _TranscribedTextWidgetState extends State<TranscribedTextWidget> {
  late final TextEditingController _controller =
      widget.controller ?? TextEditingController();

  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    // Only dispose if we created it internally
    if (widget.controller == null) _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_focusNode),
      child: Container(
        height: size.height * 0.2,
        width: size.width * 0.95,
        margin: const EdgeInsets.symmetric(vertical: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          maxLines: null,
          decoration: const InputDecoration(
            hintText: "Tap here to type…",
            border: InputBorder.none,
          ),
          style: const TextStyle(fontSize: 18, color: Colors.black),
          onChanged: widget.onTextChanged, // ✅ important
        ),
      ),
    );
  }
}