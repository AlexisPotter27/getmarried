import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/data/models/chip_choice_mode.dart';

class ChipsBox extends StatefulWidget {
  const ChipsBox({Key? key, required this.items}) : super(key: key);
  final List<ChipChoiceModel> items;

  @override
  State<ChipsBox> createState() => _ChipsBoxState();
}

class _ChipsBoxState extends State<ChipsBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(16)),
      child: Wrap(
        spacing: 5,
        children: List.generate(
            widget.items.length,
            (index) => Chip(
                backgroundColor: primaryColour.withOpacity(0.3),
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      widget.items[index].icon,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(widget.items[index].label),
                  ],
                ))),
      ),
    );
  }
}
