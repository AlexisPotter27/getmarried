import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/widgets/home/age_selector_card.dart';
class LocationRangeSelector extends StatefulWidget {
  const LocationRangeSelector({Key? key}) : super(key: key);

  @override
  State<LocationRangeSelector> createState() => _LocationRangeSelectorState();
}

class _LocationRangeSelectorState extends State<LocationRangeSelector> {
  RangeValues rangeValues = const RangeValues(5, 200);

  bool _seeEitherSide = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Location Range',
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
                'Between ${rangeValues.start.round()} and ${rangeValues.end.round()} miles.',
                style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 13),
              ),
              SliderTheme(
                data: SliderThemeData(
                    trackHeight: 2,
                    activeTrackColor: primaryColour,
                    trackShape: CustomTrackShape(),
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 20,disabledThumbRadius: 20),
                    inactiveTrackColor: primaryColour.withOpacity(0.5),
                    thumbColor: primaryColour),
                child: RangeSlider(
                  values: rangeValues,

                  onChanged: (val) {
                    setState(() {
                      rangeValues = val;
                    });
                  },
                  min: 5,
                  max: 200,
                ),
              ),

              // SizedBox(height: 16,)

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     const Expanded(
              //       child: Text(
              //         'See people 2 years either side if i run out',
              //         style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              //       ),
              //     ),
              //     Transform.scale(
              //       scale: 0.8,
              //       child: CupertinoSwitch(
              //           value: _seeEitherSide,
              //           onChanged: (val) {
              //             setState(() {
              //               _seeEitherSide = val;
              //             });
              //           },
              //           activeColor: primaryColour),
              //     )
              //   ],
              // ),
            ],
          ),
        )
      ],
    );
  }
}
