import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getmarried/constant.dart';

class ExerciseBottomSheet extends StatefulWidget {
  const ExerciseBottomSheet({Key? key}) : super(key: key);

  @override
  State<ExerciseBottomSheet> createState() => _ExerciseBottomSheetState();
}

class _ExerciseBottomSheetState extends State<ExerciseBottomSheet> {
  List<String> selectedEverciseOption = [];
  bool showOthers = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.black,
                    )),
                const Text(
                  'Do they exercise?',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: exerciseOptions.length,
                itemBuilder: (context, index) => CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    value: selectedEverciseOption.contains(religions[index]),
                    activeColor: primaryColour,
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (val) {
                      setState(() {
                        if (val!) {
                          selectedEverciseOption.add(exerciseOptions[index]);
                        } else {
                          selectedEverciseOption.remove(exerciseOptions[index]);
                        }
                      });
                    },
                    checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(
                            width: 0.5, color: Colors.grey.shade300)),
                    title: Text(exerciseOptions[index])),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Show other people if i run out',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                      value: showOthers,
                      activeColor: primaryColour,
                      onChanged: (bool value) {
                        setState(() {
                          showOthers = value;
                        });
                      },
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

List<String> exerciseOptions = [
  'Active',
  'Sometimes',
  'Almost never',
];
