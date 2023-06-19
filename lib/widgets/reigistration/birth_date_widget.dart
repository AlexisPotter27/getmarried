import 'dart:developer';
import 'package:flutter/material.dart';
import 'form_field.dart';

class BirthDateWidget extends StatefulWidget {
  const BirthDateWidget(
      {Key? key,
      required this.dayController,
      required this.yearController,
      required this.monthController})
      : super(key: key);
  final TextEditingController dayController;

  final TextEditingController yearController;

  final TextEditingController monthController;

  @override
  State<BirthDateWidget> createState() => _BirthDateWidgetState();
}

class _BirthDateWidgetState extends State<BirthDateWidget> {
  final dayFocusNode = FocusNode();
  final monthFocusNode = FocusNode();
  final yearFocusNode = FocusNode();
  // late final int britYear;

  // TextEditingController dayController = TextEditingController();
  // TextEditingController yearController = TextEditingController();
  // TextEditingController monthController = TextEditingController();

  // void yearBirth() {
  //   String year = widget.yearController.text.toString();
  //   britYear = int.parse(year);
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Month',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: 60,
              height: 50,
              child: CustomFormField(
                focusNode: dayFocusNode,
                maxLenght: 2,

                hintText: 'MM',

                keyboardType: TextInputType.number,
                controller: widget.monthController,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                onChanged: (val) {
                  log(val.length.toString());
                  if (val.length == 2) {
                    dayFocusNode.unfocus();
                    monthFocusNode.requestFocus();
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Day',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: 60,
              height: 50,
              child: CustomFormField(
                focusNode: monthFocusNode,
                maxLenght: 2,
                hintText: 'DD',
                keyboardType: TextInputType.number,
                controller: widget.dayController,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                onChanged: (val) {
                  log(val.length.toString());
                  if (val.length == 2) {
                    monthFocusNode.unfocus();
                    yearFocusNode.requestFocus();
                  }
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Year',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: 70,
              height: 50,
              child: CustomFormField(
                focusNode: yearFocusNode,
                maxLenght: 4,
                hintText: 'YYYY',
                keyboardType: TextInputType.number,
                controller: widget.yearController,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                onChanged: (val) {
                  log(val.length.toString());
                  // yearBirth();
                  if (val.length == 4) {
                    yearFocusNode.unfocus();
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
