import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({Key? key, required this.child, required this.onPressed}) : super(key: key);
  final Widget child;
  final VoidCallback onPressed;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed:widget.onPressed,
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shape: const StadiumBorder(),
              padding: const EdgeInsets.all(18),
              onPrimary: Colors.black,
              elevation: 0
            ),
            child: widget.child,
          ),
        ),
      ],
    );
  }
}
