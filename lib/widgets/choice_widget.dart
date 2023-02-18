import 'dart:developer';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';

import '../models/chip_choice_mode.dart';

class ChoiceWidget extends StatefulWidget {
  const ChoiceWidget({Key? key, required this.options, required this.tittle, required this.onSelectionShaged})
      : super(key: key);
  final List<ChipChoiceModel> options;
  final String tittle;
  final Function(List<ChipChoiceModel>) onSelectionShaged;

  @override
  State<ChoiceWidget> createState() => _ChoiceWidgetState();
}

class _ChoiceWidgetState extends State<ChoiceWidget> {
  List<ChipChoiceModel> selectedOptions = [];
  List<ChipChoiceModel> showingSelections = [];
  double maxHeight = 150;

  bool isExpanded = false;

  @override
  void initState() {
    super.initState();

    if (widget.options.length > 5) {
      showingSelections = List<ChipChoiceModel>.from(widget.options.take(4));
      log('greater');
    } else {
      showingSelections = widget.options;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.tittle,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(
            height: 10,
          ),
          ChipsChoice<ChipChoiceModel>.multiple(
              value: selectedOptions,
              wrapped: true,
              onChanged: (values) {
                setState(() {
                  selectedOptions = values;
                  widget.onSelectionShaged(values);
                });
              },
              alignment: WrapAlignment.start,
              choiceLabelBuilder: (item) => _ChoiceLabelBuilder(
                    label: item.label,
                    isSelected: item.selected,
                    icon: item.value.icon,
                  ),
              choiceActiveStyle: const C2ChoiceStyle(
                  color: Colors.white,
                  backgroundColor: Colors.black,
                  borderColor: Colors.black,
                  showCheckmark: false),
              choiceItems: List.generate(
                  showingSelections.length,
                  (index) => C2Choice(
                      value: showingSelections[index],
                      label: showingSelections[index].label)),
              choiceStyle: const C2ChoiceStyle(
                color: Colors.black,
              )),
          Visibility(
            visible: widget.options.length > 5,
            child: Center(
              child: GestureDetector(
                  child: Text(isExpanded ? 'Show less' : 'Show more', style: const TextStyle(color: Colors.white)),
                  onTap: () {
                    isExpanded = !isExpanded;
                    sort();
                  }),
            ),
          )
        ],
      ),
    );
  }

  void sort() {
    setState(() {
      if (widget.options.length > showingSelections.length) {
        showingSelections = widget.options;
      } else {
        showingSelections = List<ChipChoiceModel>.from(widget.options.take(4));
      }
    });
  }
}

class _ChoiceLabelBuilder extends StatelessWidget {
  const _ChoiceLabelBuilder(
      {Key? key,
      required this.label,
      required this.isSelected,
      required this.icon})
      : super(key: key);
  final String label;
  final bool isSelected;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: isSelected ? Colors.white : Colors.black,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(label)
      ],
    );
  }
}
