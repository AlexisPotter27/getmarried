import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/data/models/chip_choice_mode.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/widgets/reigistration/choice_widget.dart';
import 'package:getmarried/widgets/reigistration/next_button.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({Key? key, required this.onComplete}) : super(key: key);
  final Function(List<String>? interest) onComplete;

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen>
    with AutomaticKeepAliveClientMixin {
  List<ChipChoiceModel> creativitySelections = [];
  List<ChipChoiceModel> sportsSelections = [];
  List<ChipChoiceModel> goingOutSelections = [];
  List<ChipChoiceModel> filmTvSelections = [];
  List<ChipChoiceModel> stayingInSelections = [];

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
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Your interests',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Pick 5 things you love. It will help you match with people who love them too.',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ChoiceWidget(
                  options: creativityChoices,
                  tittle: 'Creativity',
                  onSelectionShaged: (List<ChipChoiceModel> selection) {
                    setState(() {
                      creativitySelections = selection;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                ChoiceWidget(
                    options: sports,
                    tittle: 'Sports',
                    onSelectionShaged: (val) {
                      setState(() {
                        sportsSelections = val;
                      });
                    }),
                const SizedBox(
                  height: 10,
                ),
                ChoiceWidget(
                    options: goingOut,
                    tittle: 'Going out',
                    onSelectionShaged: (val) {
                      setState(() {
                        goingOutSelections = val;
                      });
                    }),
                const SizedBox(
                  height: 10,
                ),
                ChoiceWidget(
                    options: stayingIn,
                    tittle: 'Staying in',
                    onSelectionShaged: (val) {
                      setState(() {
                        stayingInSelections = val;
                      });
                    }),
                const SizedBox(
                  height: 10,
                ),
                ChoiceWidget(
                    options: filmTv,
                    tittle: 'Film & Tv',
                    onSelectionShaged: (val) {
                      setState(() {
                        filmTvSelections = val;
                      });
                    }),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      onTap: () {
                        // widget.onComplete();
                      },
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  '${selectedCategories()}/5 selected',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                NextButton(onPressed: () {
                  if (allInterests.isEmpty) {
                    showCustomToast('Select atleast one interest');
                  } else {
                    log(allInterests.length.toString());
                    widget.onComplete(allInterests);
                  }
                })
              ],
            )
          ],
        )
      ],
    );
  }

  List<ChipChoiceModel> get all => [
        ...sportsSelections,
        ...filmTvSelections,
        ...creativitySelections,
        ...stayingInSelections,
        ...goingOutSelections
      ];

  List<String> get allInterests => all.map((e) => e.label).toList();

  String selectedCategories() {
    int selections = 0;
    if (sportsSelections.isNotEmpty) {
      selections += 1;
    }
    if (filmTvSelections.isNotEmpty) {
      selections += 1;
    }
    if (creativitySelections.isNotEmpty) {
      selections += 1;
    }
    if (stayingInSelections.isNotEmpty) {
      selections += 1;
    }
    if (goingOutSelections.isNotEmpty) {
      selections += 1;
    }

    return selections.toString();
  }

  @override
  bool get wantKeepAlive => true;
}

class _ChoiceLabelBuilder extends StatelessWidget {
  const _ChoiceLabelBuilder(
      {Key? key,
      required this.label,
      required this.isSelected,
      required this.icon})
      : super(key: key);
  final String label;
  final bool isSelected;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 16,
          color: isSelected ? Colors.white : Colors.black,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(label)
      ],
    );
  }
}
