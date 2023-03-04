import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';



class CustomRadioTile<T> extends StatefulWidget {
  final Widget? subTittle;

  final TextStyle? tittleStyle;
  final VoidCallback onSubtitleClicked;
  final void Function(dynamic) onChanged;
  final bool toggleSubtitle;
  final String tittle;

  final T value;
  final T groupValue;

  CustomRadioTile(
      {Key? key,
       this.subTittle,
      this.tittleStyle,
      required this.onSubtitleClicked,
      required this.toggleSubtitle,
      required this.value,
      required this.groupValue,
      required this.tittle,
      required this.onChanged})
      : super(key: key);

  @override
  State<CustomRadioTile> createState() => _CustomRadioTileState();
}

class _CustomRadioTileState extends State<CustomRadioTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onChanged(widget.value);
        setState(() {
          log('${widget.value},${widget.groupValue}');
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.tittle,
                    style: widget.tittleStyle ??
                        const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  widget.toggleSubtitle ?
                  AnimatedCrossFade(
                    firstChild: GestureDetector(
                      onTap: widget.onSubtitleClicked,
                      child: widget.subTittle?? SizedBox(),
                    ),
                    secondChild: const SizedBox.shrink(),
                    crossFadeState: shouldOpen
                        ? CrossFadeState.showFirst
                        : CrossFadeState.showSecond,
                    duration: const Duration(milliseconds: 300),
                  ):
                      widget.subTittle ?? SizedBox()
                ],
              ),
            ),
           const SizedBox(width: 10,),
            isSelected
                ?  const Icon(
                    Icons.check_circle,
                    color: primaryColour,
                  )
                : const Icon(Icons.radio_button_off)
          ],
        ),
      ),
    );
  }

  bool get isSelected => widget.value == widget.groupValue;

  bool get shouldOpen => widget.toggleSubtitle && isSelected;
}
