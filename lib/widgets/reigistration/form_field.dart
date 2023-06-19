import 'package:flutter/material.dart';
import '../../constants/constant.dart';

class CustomFormField extends StatefulWidget {


  const CustomFormField(
      {Key? key,
      required this.focusNode,
      this.hintText,
      this.controller,
      this.validator,
      this.onChanged,
      this.keyboardType,
      this.prefixIcon,
      this.suffixIcon,
      this.enabled,
      this.padding, this.maxLenght,
        this.maxLines})
      : super(key: key);
  final FocusNode focusNode;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? enabled;
  final int? maxLenght;
  final int? maxLines;


  final EdgeInsetsGeometry? padding;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType ?? TextInputType.name,
      controller: widget.controller,
      maxLength: widget.maxLenght,
      cursorColor: primaryColour,
      cursorHeight: 24,
      focusNode: widget.focusNode,
      maxLines: widget.maxLines,
      style: const TextStyle(color: Colors.black,fontSize: 16 ),
      decoration: inputDecoration(context).copyWith(
          hintText: widget.hintText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          counterText: '',
          hintStyle: const TextStyle(color: Colors.black38,fontSize: 16),
          contentPadding: widget.padding),
    );
  }




}




