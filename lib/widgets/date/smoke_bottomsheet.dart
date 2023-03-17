import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';

class SmokeBottomScheet extends StatefulWidget {
  const SmokeBottomScheet({Key? key, required this.onSelected, this.value})
      : super(key: key);
  final Function(String value) onSelected;
  final String? value;

  @override
  State<SmokeBottomScheet> createState() => _SmokeBottomScheetState();
}

class _SmokeBottomScheetState extends State<SmokeBottomScheet> {
  List<String> selectedSmokeOption = [];
  bool showOthers = false;

  String? selectedOption;

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
                  'Do they smoke? ',
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
                itemCount: smokeOptions.length,
                itemBuilder: (context, index) => RadioListTile<String>(
                  contentPadding: EdgeInsets.zero,
                  value: smokeOptions[index],
                  activeColor: primaryColour,
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (val) {
                    setState(() {
                      if (val != null) {
                        widget.onSelected(val);
                      }
                    });
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side:
                          BorderSide(width: 0.5, color: Colors.grey.shade300)),
                  title: Text(smokeOptions[index]),
                  groupValue: widget.value,
                ),
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

List<String> smokeOptions = [
  'Socially',
  'Regularly',
  'Never',
];
