import 'package:flutter/material.dart';

class UpgradeButton extends StatefulWidget {
  final VoidCallback onPressed;

  final Widget child;

  const UpgradeButton({Key? key, required this.onPressed, required this.child})
      : super(key: key);

  @override
  State<UpgradeButton> createState() => _UpgradeButtonState();
}

class _UpgradeButtonState extends State<UpgradeButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: TextButton(

            onPressed: widget.onPressed,
            style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                shape: const StadiumBorder(),
                textStyle: const TextStyle(fontSize: 13),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                foregroundColor: Colors.black),
            child: widget.child,
          ),
        ),
      ],
    );
  }
}
