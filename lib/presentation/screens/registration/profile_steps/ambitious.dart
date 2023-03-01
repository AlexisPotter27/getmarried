import 'package:flutter/material.dart';
import 'package:getmarried/widgets/reigistration/custom_radio_tile.dart';
import 'package:getmarried/widgets/reigistration/next_button.dart';


class Ambitious extends StatefulWidget {
  const Ambitious({Key? key, required this.onComplete}) : super(key: key);
  final Function onComplete;

  @override
  State<Ambitious> createState() => _AmbitiousState();
}

class _AmbitiousState extends State<Ambitious> {
  String value = '';

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
                Icons.work,
                size: 25,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "I feel like I'm an ambitious person ?",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomRadioTile<String>(
                onSubtitleClicked: () {},
                toggleSubtitle: false,
                value: "doesn't apply to me",
                groupValue: value,
                tittle: "Doesn't apply to me",
                onChanged: (val) {
                  setState(() {
                    value = val;
                  });
                },
              ),
              const SizedBox(
                height: 16,
              ),
              CustomRadioTile<String>(
                onSubtitleClicked: () {},
                toggleSubtitle: false,
                value: 'slightly applies to me',
                groupValue: value,
                tittle: 'Slightly applies to me',
                onChanged: (val) {
                  setState(() {
                    value = val;
                  });
                },
              ),
              const SizedBox(
                height: 16,
              ),
              CustomRadioTile<String>(
                onSubtitleClicked: () {},
                toggleSubtitle: false,
                value: 'applies to me',
                groupValue: value,
                tittle: 'Applies to me',
                onChanged: (val) {
                  setState(() {
                    value = val;
                  });
                },
              ),
              const SizedBox(
                height: 16,
              ),
              CustomRadioTile<String>(
                onSubtitleClicked: () {},
                toggleSubtitle: false,
                value: 'core to who I am',
                groupValue: value,
                tittle: 'Core to who I am',
                onChanged: (val) {
                  setState(() {
                    value = val;
                  });
                },
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
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500, ),
                ),onTap: (){
                widget.onComplete();
              },),
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
