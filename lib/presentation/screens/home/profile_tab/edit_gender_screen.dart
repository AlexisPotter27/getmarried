import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/widgets/reigistration/about_gender_dialog.dart';
import 'package:getmarried/widgets/reigistration/custom_radio_tile.dart';

class EditGenderScreen extends StatefulWidget {
  const EditGenderScreen(
      {Key? key, required this.onComplete, required this.onPrev})
      : super(key: key);
  final Function(String gender) onComplete;
  final Function onPrev;

  @override
  State<EditGenderScreen> createState() => _EditGenderScreenState();
}

List<String> options = [
  'Man',
  'Woman',
];
String radioValue = 'Man';

class _EditGenderScreenState extends State<EditGenderScreen> {
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
                      outlinedBorder: true,
                      subTittle: Row(
                        children: const [
                          Text('Add more about your gender'),
                          Icon(Icons.keyboard_arrow_down)
                        ],
                      ),
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

class ShowGenderWidget extends StatefulWidget {
  const ShowGenderWidget({Key? key}) : super(key: key);

  @override
  State<ShowGenderWidget> createState() => _ShowGenderWidgetState();
}

class _ShowGenderWidgetState extends State<ShowGenderWidget> {
  bool hiddenFromProfile = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CupertinoSwitch(
              value: hiddenFromProfile,
              onChanged: (val) {
                setState(() {
                  hiddenFromProfile = val;
                });
              },
              activeColor: primaryColour,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Hidden from your profile',
              style: TextStyle(fontWeight: FontWeight.w500),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Shown as:',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: hiddenFromProfile ? Colors.black54 : Colors.black),
              ),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                    primary:
                        hiddenFromProfile ? Colors.black54 : Colors.white,
                    shape: StadiumBorder(
                        side: hiddenFromProfile
                            ? const BorderSide(color: Colors.black)
                            : BorderSide.none),
                    backgroundColor:
                        hiddenFromProfile ? Colors.transparent : Colors.black),
                child: const Text('Man'),
              )
            ],
          ),
        )
      ],
    );
  }
}
