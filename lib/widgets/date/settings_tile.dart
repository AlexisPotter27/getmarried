import 'package:flutter/material.dart';

class SettingsTile extends StatefulWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? suffixIconCOlor;
  final Widget? tittle;

  const SettingsTile(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.prefixIcon,
      this.suffixIcon,
      this.tittle,
      this.backgroundColor,
      this.textColor,
      this.suffixIconCOlor})
      : super(key: key);
  final String text;
  final VoidCallback onPressed;

  @override
  State<SettingsTile> createState() => _SettingsTileState();
}

class _SettingsTileState extends State<SettingsTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.tittle ?? const SizedBox.shrink(),
        GestureDetector(
          onTap: () {
            widget.onPressed();
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: widget.backgroundColor,
                border: widget.backgroundColor == null
                    ? Border.all(color: Colors.grey.shade300)
                    : null),
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Row(
                children: [
                  widget.prefixIcon ?? const SizedBox.shrink(),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: Text(
                    widget.text,
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: widget.textColor),
                  )),
                  widget.suffixIcon ??
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20,
                        color: widget.suffixIconCOlor ?? Colors.grey.shade300,
                      )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
