import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';

class WhiteTextField extends StatefulWidget {
  const WhiteTextField(
      {Key? key, required this.hint, required this.controller, this.onChanged})
      : super(key: key);
  final String hint;
  final TextEditingController controller;
  final Function(String)? onChanged;

  @override
  State<WhiteTextField> createState() => _WhiteTextFieldState();
}

class _WhiteTextFieldState extends State<WhiteTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextField(
      onChanged: widget.onChanged,
      controller: widget.controller,
      decoration: inputDecoration(context).copyWith(
          hintText: widget.hint,
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 16)),
    ));
  }
}
