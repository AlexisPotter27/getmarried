import 'package:flutter/material.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/widgets/reigistration/custom_radio_tile.dart';
import 'package:getmarried/widgets/reigistration/next_button.dart';

class PartnersBodyType extends StatefulWidget {
  const PartnersBodyType(
      {Key? key, required this.onComplete, required this.onPrev})
      : super(key: key);
  final Function(String? pBodyType) onComplete;
  final Function onPrev;

  @override
  State<PartnersBodyType> createState() => _PartnersBodyTypeState();
}

class _PartnersBodyTypeState extends State<PartnersBodyType> {
  String value = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
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
                  'What is your ideal partners\nbody type ?',
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
                  value: 'doesnt matter',
                  groupValue: value,
                  tittle: 'It doesn\'t matter to me ',
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
