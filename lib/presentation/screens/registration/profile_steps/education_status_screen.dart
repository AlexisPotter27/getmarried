import 'package:flutter/material.dart';
import 'package:getmarried/constant.dart';
import 'package:getmarried/widgets/reigistration/custom_radio_tile.dart';

import 'package:getmarried/widgets/reigistration/next_button.dart';


class EducationStatus extends StatefulWidget {
  const EducationStatus({Key? key, required this.onComplete}) : super(key: key);
  final Function onComplete;


  @override
  State<EducationStatus> createState() => _EducationStatusState();
}

class _EducationStatusState extends State<EducationStatus> {
  String value = '';
  late List<String> educationLevels;

  @override
  void initState() {
    super.initState();
    educationLevels = educations;
  }

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
              const Icon(
                Icons.school_outlined,
                size: 25,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'What is your Education level?',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                itemCount: educationLevels.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => Column(children: [
                  CustomRadioTile<String>(
                    onSubtitleClicked: () {},
                    toggleSubtitle: false,
                    value: educationLevels[index],
                    groupValue: value,
                    tittle:  educationLevels[index],
                    onChanged: (val) {
                      setState(() {
                        value = val;
                      });
                    },
                   ),
                  const  SizedBox(height: 16,)
                ],),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: const Text(
                  'Skip',
                  style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                ),
                onTap: (){
                  widget.onComplete();
                },
              ),
              NextButton(onPressed: () {
                widget.onComplete();
              }),
            ],
          ),
        )
      ],
    );
  }
}
