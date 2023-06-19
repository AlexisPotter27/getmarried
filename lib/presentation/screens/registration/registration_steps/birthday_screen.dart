import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/widgets/reigistration/birth_date_widget.dart';
import 'package:getmarried/widgets/reigistration/next_button.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen(
      {Key? key, required this.onComplete, required this.onPrev})
      : super(key: key);
  final Function(DateTime date) onComplete;
  final Function onPrev;

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

List options = [
  'Man',
  'Woman',
];
String radioValue = 'Man';

class _BirthdayScreenState extends State<BirthdayScreen> {
  TextEditingController dayController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController monthController = TextEditingController();

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
              const Text(
                'When is your birthday ?',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 16,
              ),
              BirthDateWidget(
                dayController: dayController,
                monthController: monthController,
                yearController: yearController,
              )
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  NextButton(
                      isNext: false,
                      onPressed: () {
                        widget.onPrev();
                      }),
                  // const Icon(Icons.lock, color: Colors.white),
                  // const SizedBox(
                  //   width: 5,
                  // ),
                  // const Expanded(
                  //     child: Text(
                  //   'We only show your age to potential matches, not your birthday',
                  //   style: TextStyle(
                  //       fontWeight: FontWeight.w500, color: Colors.white),
                  // ))
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            NextButton(onPressed: () {
              if (dayController.text.isEmpty) {
                showCustomToast('Enter day of birth');
              } else if (monthController.text.isEmpty) {
                showCustomToast('Enter month of birth');
              } else if (yearController.text.isEmpty) {
                showCustomToast('Enter year of birth');
              } else {
                DateTime dob = DateTime(
                    int.parse(yearController.text),
                    int.parse(monthController.text),
                    int.parse(dayController.text));
                log(dob.year.toString());
                widget.onComplete(dob);
              }
            }),
          ],
        )
      ],
    );
  }
}
