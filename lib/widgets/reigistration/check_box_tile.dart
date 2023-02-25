import 'package:flutter/material.dart';
import 'package:getmarried/constant.dart';

class CheckBoxTile extends StatefulWidget {
  const CheckBoxTile(
      {Key? key,
      required this.text,
      required this.isChecked,
      required this.onChanged})
      : super(key: key);
  final String text;
  final bool isChecked;
  final Function(bool?) onChanged;

  @override
  State<CheckBoxTile> createState() => _CheckBoxTileState();
}

class _CheckBoxTileState extends State<CheckBoxTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.isChecked);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.text,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
          Icon(
            widget.isChecked ? Icons.check_box : Icons.check_box_outline_blank,
            color: widget.isChecked ? primaryColour : Colors.grey,
          )
        ],
      ),
    );
  }
}
