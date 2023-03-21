import 'package:flutter/material.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/widgets/reigistration/custom_radio_tile.dart';
import 'package:getmarried/widgets/reigistration/next_button.dart';

class Relationship extends StatefulWidget {
  const Relationship({Key? key, required this.onComplete, required this.onPrev})
      : super(key: key);
  final Function(String? relationShip) onComplete;
  final Function onPrev;

  @override
  State<Relationship> createState() => _RelationshipState();
}

class _RelationshipState extends State<Relationship> {
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
                Icons.handshake_sharp,
                size: 25,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'To me, sex in a relationship is:',
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
                value: 'not important',
                groupValue: value,
                tittle: 'Not Important',
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
                value: 'slightly important',
                groupValue: value,
                tittle: 'Slightly Important',
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
                value: 'important',
                groupValue: value,
                tittle: 'Important',
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
                value: 'extremely important',
                groupValue: value,
                tittle: 'Extremely Important',
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
                value: 'rather not say',
                groupValue: value,
                tittle: 'Rather not say',
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
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              NextButton(
                  onPressed: () {
                    widget.onPrev();
                  },
                  isNext: false),
              Expanded(
                child: Center(
                  child: GestureDetector(
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
                ),
              ),
              NextButton(onPressed: () {
                if (value.isEmpty) {
                  showCustomToast('Select an option');
                } else {
                  widget.onComplete(value);
                }
              }),
            ],
          ),
        )
      ],
    );
  }
}
