import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';

class AgeSelectorCard extends StatefulWidget {
  const AgeSelectorCard({Key? key}) : super(key: key);

  @override
  State<AgeSelectorCard> createState() => _AgeSelectorCardState();
}

class _AgeSelectorCardState extends State<AgeSelectorCard> {
  RangeValues rangeValues = const RangeValues(19, 50);

  bool _seeEitherSide = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Age',
            style: TextStyle(fontSize: 13),
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Between ${rangeValues.start.round()} and ${rangeValues.end.round()}.',
                style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 13),
              ),
              SliderTheme(
                data: SliderThemeData(
                    trackHeight: 2,
                    activeTrackColor: primaryColour,
                    trackShape: CustomTrackShape(),
                    inactiveTrackColor: primaryColour.withOpacity(0.5),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 20,disabledThumbRadius: 20),
                    thumbColor: primaryColour),
                child: RangeSlider(
                  values: rangeValues,

                  onChanged: (val) {
                    setState(() {
                      rangeValues = val;
                    });
                  },
                  min: 18,
                  max: 66,
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'See people 2 years either side if i run out',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                        value: _seeEitherSide,
                        onChanged: (val) {
                          setState(() {
                           _seeEitherSide = val;
                          });
                        },
                        activeColor: primaryColour),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}


class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}