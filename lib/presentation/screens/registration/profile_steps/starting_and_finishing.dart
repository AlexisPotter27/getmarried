import 'package:flutter/material.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/widgets/reigistration/custom_radio_tile.dart';
import 'package:getmarried/widgets/reigistration/next_button.dart';


class StartingAndFinishing extends StatefulWidget {
  const StartingAndFinishing({Key? key, required this.onComplete, required this.onPrev}) : super(key: key);
  final Function(String? startAndFinish) onComplete;
  final Function onPrev;

  @override
  State<StartingAndFinishing> createState() => _StartingAndFinishingState();
}

class _StartingAndFinishingState extends State<StartingAndFinishing> {
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
                Icons.directions_walk,
                size: 25,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "I'm good at starting and finishing things: ",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomRadioTile<String>(
                onSubtitleClicked: () {},
                toggleSubtitle: false,
                value: "doesn't apply to me",
                groupValue: value,
                tittle: "Doesn't apply to me",
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
                value: 'slightly applies to me',
                groupValue: value,
                tittle: 'Slightly applies to me',
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
                value: 'applies to me',
                groupValue: value,
                tittle: 'Applies to me',
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
                value: 'core to who I am',
                groupValue: value,
                tittle: 'Core to who I am',
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
