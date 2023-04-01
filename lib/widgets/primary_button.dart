import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({Key? key, required this.child, required this.onPressed,  this.bgColor, this.padding}) : super(key: key);
  final Widget child;
  final VoidCallback onPressed;
  final Color? bgColor;
  final EdgeInsetsGeometry? padding;

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
              primary:widget.bgColor?? primaryColour,
              shape: const StadiumBorder(),
              padding:widget.padding ?? const EdgeInsets.all(18),
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
