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
    return InkWell(
      onTap: widget.onPressed,
      // style: ElevatedButton.styleFrom(
      //     padding: const EdgeInsets.all(16),
      //     shape: const CircleBorder(),
      //     primary: Colors.white,
      //     onPrimary: Colors.white.withOpacity(0.7),
      //     onSurface: Colors.white.withOpacity(0.5),
      //     shadowColor: Colors.black),
      child: widget.isNext
          ? Image.asset(
              'assets/forward.png',
              height: 35,
              width: 35,
            )
          : Image.asset(
              'assets/backward.png',
              height: 35,
              width: 35,
            ),
    );
  }
}
