import 'package:flutter/material.dart';

class NextButton extends StatefulWidget {
  final VoidCallback onPressed;
  final bool isNext;

  const NextButton({Key? key, required this.onPressed, this.isNext = true})
      : super(key: key);

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
      child: widget.isNext
          ? Image.asset(
              'assets/front.png',
              height: 25,
              width: 25,
            )
          : Image.asset(
              'assets/back.png',
              height: 25,
              width: 25,
            ),
    );
  }
}
