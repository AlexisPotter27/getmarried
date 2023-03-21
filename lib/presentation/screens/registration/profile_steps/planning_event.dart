import 'package:flutter/material.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/widgets/reigistration/custom_radio_tile.dart';
import 'package:getmarried/widgets/reigistration/next_button.dart';

class PlanningEvent extends StatefulWidget {
  const PlanningEvent(
      {Key? key, required this.onComplete, required this.onPrev})
      : super(key: key);
  final Function(String? event) onComplete;
  final Function onPrev;

  @override
  State<PlanningEvent> createState() => _PlanningEventState();
}

class _PlanningEventState extends State<PlanningEvent> {
  String value = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Icon(
                Icons.celebration_sharp,
                size: 25,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Chose event for both of you",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomRadioTile<String>(
                onSubtitleClicked: () {},
                toggleSubtitle: false,
                value: 'a surprise getaway / vacation',
                groupValue: value,
                tittle: 'A surprise getaway / vacation',
                onChanged: (val) {
                  setState(() {
                    value = val;
                  });
                },
              ),
              const SizedBox(
                height: 16,
              ),
              CustomRadioTile<String>(
                onSubtitleClicked: () {},
                toggleSubtitle: false,
                value: 'an activity that you both like in town',
                groupValue: value,
                tittle: 'An activity that you both like in town',
                onChanged: (val) {
                  setState(() {
                    value = val;
                  });
                },
              ),
              const SizedBox(
                height: 16,
              ),
              CustomRadioTile<String>(
                onSubtitleClicked: () {},
                toggleSubtitle: false,
                value: 'dinner at a restaurant',
                groupValue: value,
                tittle: 'Dinner at a restaurant',
                onChanged: (val) {
                  setState(() {
                    value = val;
                  });
                },
              ),
              const SizedBox(
                height: 16,
              ),
              CustomRadioTile<String>(
                onSubtitleClicked: () {},
                toggleSubtitle: false,
                value: 'a concert, movies or a play',
                groupValue: value,
                tittle: 'A concert, movies or a play',
                onChanged: (val) {
                  setState(() {
                    value = val;
                  });
                },
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NextButton(
                isNext: false,
                onPressed: () {
                  widget.onPrev();
                }),
            GestureDetector(
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                widget.onComplete(null);
              },
            ),
            NextButton(onPressed: () {
              if (value.isEmpty) {
                showCustomToast('Select an option');
              } else {
                widget.onComplete(value);
              }
            }),
          ],
        )
      ],
    );
  }
}
