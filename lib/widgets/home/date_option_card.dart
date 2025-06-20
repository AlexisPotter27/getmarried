import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:collection/collection.dart';

class DateOptionCard extends StatefulWidget {
  const DateOptionCard({
    Key? key,
    required this.onValueChanged, required this.value,
  }) : super(key: key);
  final Function(String date) onValueChanged;
  final String value;

  @override
  State<DateOptionCard> createState() => _DateOptionCardState();
}

class _DateOptionCardState extends State<DateOptionCard> {
  List dates = [];
  String date = 'men';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Who you want to date',
            style: TextStyle(fontSize: 13),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     const Text(
              //       'Im open to dating everyone',
              //       style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              //     ),
              //     SizedBox(
              //       child: Transform.scale(
              //         scale: 0.7,
              //         child: CupertinoSwitch(
              //             value: allChecked,
              //             onChanged: (val) {
              //               setState(() {
              //                 if (val) {
              //                   dates = ['Men', 'Women', 'Nonbinary'];
              //                 } else {
              //                   dates = [''];
              //                 }
              //               });
              //             },
              //             activeColor: primaryColour),
              //       ),
              //     )
              //   ],
              // ),
              // const Divider(
              //   thickness: 1,
              // ),

              RadioListTile<String>(
                  value: 'men',
                  groupValue: widget.value,
                  controlAffinity: ListTileControlAffinity.trailing,
                  contentPadding: EdgeInsets.zero,
                  activeColor: primaryColour,
                  onChanged: (val) {
                   widget.onValueChanged(val!);
                  },
                  title: const Text('Men', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),)),
              const Divider(
                thickness: 1,
              ),
              RadioListTile<String>(
                  value: 'women',
                  groupValue: widget.value,
                  controlAffinity: ListTileControlAffinity.trailing,
                  contentPadding: EdgeInsets.zero,
                  activeColor: primaryColour,
                  onChanged: (val) {
                    widget.onValueChanged(val!);

                  },
                  title: const Text('Women', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),)),
              // CheckBoxTile(
              //     text: 'Men',
              //     isChecked: menChecked,
              //     onChanged: (val) {
              //       updateDates('Men');
              //     }),
              // const Divider(
              //   thickness: 1,
              // ),
              // CheckBoxTile(
              //     text: 'Women',
              //     isChecked: womenChecked,
              //     onChanged: (val) {
              //       updateDates('Women');
              //     }),
              // const Divider(
              //   thickness: 1,
              // ),
              // CheckBoxTile(
              //     text: 'Nonbinary people',
              //     isChecked: nonBinaryChecked,
              //     onChanged: (val) {
              //       updateDates('Nonbinary');
              //     }),
              // const SizedBox(
              //   height: 16,
              // )
            ],
          ),
        ),
      ],
    );
  }

  bool get menChecked => dates.contains('Men');

  bool get womenChecked => dates.contains('Women');

  bool get nonBinaryChecked => dates.contains('Nonbinary');

  bool get allChecked =>
      const ListEquality().equals(dates, ['Men', 'Women', 'Nonbinary']);

  void updateDates(String selectedDate) {
    setState(() {
      if (dates.contains(selectedDate)) {
        dates.remove(selectedDate);
      } else {
        dates.add(selectedDate);
      }
    });
  }
}
