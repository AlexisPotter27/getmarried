import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getmarried/widgets/reigistration/next_button.dart';
import 'package:getmarried/constant.dart';
import 'package:getmarried/widgets/reigistration/about_gender_dialog.dart';
import 'package:getmarried/widgets/reigistration/custom_radio_tile.dart';


class ImportantRole extends StatefulWidget {
  const ImportantRole({Key? key, required this.onComplete}) : super(key: key);
  final Function onComplete;

  @override
  State<ImportantRole> createState() => _ImportantRoleState();
}

List<String> options = ['I have never been married', 'I have been engaged before', 'I am divorced', 'I am separated', 'I am a widower' ];
String radioValue = 'Someone to raise a family with';

// final List gender = ['What to get married within 1 year', 'Want to get married within 1-2 years', 'Want to get married within 3 years \nor more'];
// List selctedOptions = ['What to get married within 1 year', 'Want to get married within 1-2 years', 'Want to get married within 3 years or more'];

class _ImportantRoleState extends State<ImportantRole> {
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
                'What best describes your marriage life ?',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(
                height: 30,
              ),

              const SizedBox(
                height: 16,
              ),
              ListView.builder(
                itemCount: options.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => Column(
                  children: [
                    CustomRadioTile<String>(
                      /*subTittle: Row(
                        children: const [
                          Text('Add more about your gender'),
                          Icon(Icons.keyboard_arrow_down)
                        ],
                      ),*/
                      onSubtitleClicked: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) =>  AboutGenderSheet(
                            options: aboutOptions(options[index]),
                          ),
                        );
                      },
                      toggleSubtitle: true,
                      value: options[index],
                      groupValue: radioValue,
                      tittle: options[index],
                      onChanged: (val) {
                        setState(() {
                          radioValue = val;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
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
          children: [
            Expanded(
              child: Row(
                children: const [
                  Icon(Icons.remove_red_eye, color: Colors.white),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Text(
                        'You can always update this later we got you.',
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white),
                      ))
                ],
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            NextButton(onPressed: () {
              widget.onComplete();
            }),
          ],
        )
      ],
    );
  }

  List<String> aboutOptions(String category) {
    if (category == 'Man') {
      return maleGenders;
    } else if (category == 'Woman') {
      return femaleGenders;
    } else {
      return nonBinaryGenders;
    }
  }
}

