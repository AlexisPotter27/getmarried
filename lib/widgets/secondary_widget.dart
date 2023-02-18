import 'package:flutter/material.dart';

class TransaparentButton extends StatefulWidget {
  const TransaparentButton(
      {Key? key, required this.child, required this.onPressed})
      : super(key: key);
  final Widget child;
  final VoidCallback onPressed;

  @override
  State<TransaparentButton> createState() => _TransaparentButtonState();
}

class _TransaparentButtonState extends State<TransaparentButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextButton(
          onPressed: widget.onPressed,
          style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
              primary: Colors.black,
              shape: const StadiumBorder(),
              padding: const EdgeInsets.all(16)),
          child: widget.child,
        )),
      ],
    );
  }
}
