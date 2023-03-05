import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/widgets/reigistration/about_gender_dialog.dart';
import 'package:getmarried/widgets/reigistration/custom_radio_tile.dart';
import 'package:getmarried/widgets/reigistration/next_button.dart';

class GenderScreen extends StatefulWidget {
  const GenderScreen({Key? key, required this.onComplete, required this.onPrev})
      : super(key: key);
  final Function(String gender) onComplete;
  final Function onPrev;

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

List<String> options = [
  'Man',
  'Woman',
];
String radioValue = 'Man';

class _GenderScreenState extends State<GenderScreen> {
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
                'What is your gender ?',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Pick which best describes you. then add more about your gender if you would like.',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
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
                          builder: (context) => AboutGenderSheet(
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /*  Expanded(
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
            ),*/
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: NextButton(
                  isNext: false,
                  onPressed: () {
                    widget.onPrev();
                  }),
            ),
            NextButton(onPressed: () {
              widget.onComplete(radioValue);
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
