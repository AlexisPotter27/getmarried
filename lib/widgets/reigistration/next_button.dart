import 'package:flutter/material.dart';

class NextButton extends StatefulWidget {
  final VoidCallback onPressed;

  const NextButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<NextButton> createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16),
          shape: const CircleBorder(),
          primary: Colors.white,
          onPrimary: Colors.white.withOpacity(0.7),
          onSurface: Colors.white.withOpacity(0.5),
          shadowColor: Colors.black),
      child: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
          color: Colors.black
      ),
    );
  }
}
