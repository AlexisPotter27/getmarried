import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../widgets/custom_radio_tile.dart';
import '../../../widgets/next_button.dart';

class SmokingScreen extends StatefulWidget {
  const SmokingScreen({Key? key, required this.onComplete}) : super(key: key);
  final Function onComplete;


  @override
  State<SmokingScreen> createState() => _SmokingScreenState();
}

class _SmokingScreenState extends State<SmokingScreen> {
  String value = '';
  late List<String> options;

  @override
  void initState() {
    super.initState();
    options = smokeOptions;
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
                Icons.smoking_rooms,
                size: 25,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Do you smoke?',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.builder(
                itemCount: options.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => Column(children: [
                  CustomRadioTile<String>(
                    onSubtitleClicked: () {},
                    toggleSubtitle: false,
                    value: options[index],
                    groupValue: value,
                    tittle:  options[index],
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
