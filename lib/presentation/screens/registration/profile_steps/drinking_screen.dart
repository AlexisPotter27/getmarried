import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/widgets/reigistration/custom_radio_tile.dart';
import 'package:getmarried/widgets/reigistration/next_button.dart';

class DrinkingScreen extends StatefulWidget {
  const DrinkingScreen(
      {Key? key, required this.onComplete, required this.onPrev})
      : super(key: key);
  final Function(String? drinking) onComplete;
  final Function onPrev;

  @override
  State<DrinkingScreen> createState() => _DrinkingScreenState();
}

class _DrinkingScreenState extends State<DrinkingScreen> {
  String value = '';
  late List<String> options;

  @override
  void initState() {
    super.initState();
    options = drinkingOptions;
  }

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
                Icons.wine_bar,
                size: 25,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Do you drink?',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                itemCount: options.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => Column(
                  children: [
                    CustomRadioTile<String>(
                      onSubtitleClicked: () {},
                      toggleSubtitle: false,
                      value: options[index],
                      groupValue: value,
                      tittle: options[index],
                      onChanged: (val) {
                        setState(() {
                          value = val;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    )
                  ],
                ),
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
