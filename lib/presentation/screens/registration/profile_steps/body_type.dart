import 'package:flutter/material.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/widgets/reigistration/custom_radio_tile.dart';
import 'package:getmarried/widgets/reigistration/next_button.dart';

class BodyType extends StatefulWidget {
  const BodyType({Key? key, required this.onComplete, required this.onPrev})
      : super(key: key);
  final Function(String? bodyType) onComplete;
  final Function onPrev;

  @override
  State<BodyType> createState() => _BodyTypeState();
}

class _BodyTypeState extends State<BodyType> {
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
                Icons.fitness_center_outlined,
                size: 25,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'What is your body type ?',
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
                value: 'slim',
                groupValue: value,
                tittle: 'Slim',
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
                value: 'athletic',
                groupValue: value,
                tittle: 'Athletic',
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
                value: 'average',
                groupValue: value,
                tittle: 'Average',
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
                value: 'slightly overweight',
                groupValue: value,
                tittle: 'Slightly Overweight',
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
                value: 'overweight',
                groupValue: value,
                tittle: 'Overweight',
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
