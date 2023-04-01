import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';

class Indicator extends StatefulWidget {
  const Indicator(
      {Key? key, required this.seledtedIndex, required this.items_count})
      : super(key: key);
  final int seledtedIndex;
  final int items_count;

  @override
  _IndicatorState createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.items_count,
        itemBuilder: (context, index) => AnimatedContainer(
            margin: const EdgeInsets.symmetric(vertical: 2,horizontal: 5),
            width: widget.seledtedIndex == index ? 20 : 10,
            duration: const Duration(milliseconds: 700),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),

                color: !(widget.seledtedIndex == index)
                    ?primaryColour.withOpacity(0.4)
                    : primaryColour)),
      ),
    );
  }
}
