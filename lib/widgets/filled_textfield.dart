import 'package:flutter/material.dart';

class FilledTextField extends StatefulWidget {
  final String hint;
  final Widget? suffix;
  final Widget? preffix;
  final String? preffixText;
  final int? maxLine;
  final TextInputType? inputType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final bool? enabled;
  final bool? obscured;
  final bool? isOutlined;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final String? Function(String?)? validator;

  final String? Function(String?)? onChanged;

  const FilledTextField(
      {Key? key,
      required this.hint,
      this.suffix,
      this.validator,
      this.preffix,
      this.maxLine,
      this.inputType,
      this.controller,
      this.onChanged,
      this.enabled,
      this.contentPadding,
      this.textInputAction,
      this.obscured = false,
      this.fillColor,
      this.preffixText,
      this.isOutlined = true})
      : super(key: key);

  @override
  State<FilledTextField> createState() => _FilledTextFieldState();
}

class _FilledTextFieldState extends State<FilledTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        maxLines: widget.maxLine ?? 1,
        keyboardType: widget.inputType,
        cursorColor: Colors.black,
        onChanged: widget.onChanged,
        obscureText: widget.obscured!,
        textInputAction: widget.textInputAction,
        style: TextStyle(color: Colors.black, fontSize: 16),
        decoration: InputDecoration(
            filled: true,
            hintStyle: TextStyle(color: Colors.grey),
            hintText: widget.hint,
            fillColor: Colors.grey.shade300,
            border: InputBorder.none),
      ),
    );
  }
}
