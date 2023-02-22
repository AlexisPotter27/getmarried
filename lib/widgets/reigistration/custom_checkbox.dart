import 'package:flutter/material.dart';

import '../../constant.dart';

class CustomCheckbox extends StatefulWidget {
  const CustomCheckbox(
      {Key? key, required this.text, required this.isChecked, required this.onChanged})
      : super(key: key);
  final String text;
  final bool isChecked;
  final Function(bool?) onChanged;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector( onTap: (){
      widget.onChanged(!widget.isChecked);

    },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.text),
            Icon(
              widget.isChecked ? Icons.check_box : Icons.check_box_outline_blank,
              color: widget.isChecked ? primaryColour : Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
