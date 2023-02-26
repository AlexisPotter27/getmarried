import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getmarried/constant.dart';

class ChildrenBottomsheet extends StatefulWidget {
  const ChildrenBottomsheet({Key? key}) : super(key: key);

  @override
  State<ChildrenBottomsheet> createState() => _ChildrenBottomsheetState();
}

class _ChildrenBottomsheetState extends State<ChildrenBottomsheet> {
  List<String> selectedChildrenOption = [];
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
                  'Do they have or want children? ',
                  style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w500),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: childrenOptions.length,
                itemBuilder: (context, index) => CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    value: selectedChildrenOption.contains(religions[index]),
                    activeColor: primaryColour,
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (val) {
                      setState(() {
                        if (val!) {
                          selectedChildrenOption.add(childrenOptions[index]);
                        } else {
                          selectedChildrenOption.remove(childrenOptions[index]);
                        }
                      });
                    },
                    checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(
                            width: 0.5, color: Colors.grey.shade300)),
                    title: Text(childrenOptions[index])),
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

List<String> childrenOptions = [
  'Want someday',
  'Dont want',
  'Have & want more',
  'Have and dont want more',
  'Not sure yet',

];
