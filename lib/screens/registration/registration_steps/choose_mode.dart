import 'package:flutter/material.dart';
import '../../../widgets/custom_radio_tile.dart';
import '../../../widgets/next_button.dart';

class ChooseModeScreen extends StatefulWidget {
  const ChooseModeScreen({Key? key, required this.onComplete}) : super(key: key);
  final Function onComplete;

  @override
  State<ChooseModeScreen> createState() => _ChooseModeScreenState();
}

class _ChooseModeScreenState extends State<ChooseModeScreen> {

  String radioValue = 'Man';

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
                'Choose a mode to get started ?',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Get married is for making all kinds of connections!. You will be able to switch modes once you are all setup.',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),
              ),

              const SizedBox(
                height: 16,
              ),

              //Don't Know
              CustomRadioTile<String>(
                subTittle:const Text("I don't Know", ),
                onSubtitleClicked: () {},
                toggleSubtitle: false,
                value: "don't know",
                groupValue: radioValue,
                tittle:"Don't Know",
                onChanged: (val) {
                  setState(() {
                    radioValue = val;
                  });
                },
              ),
              const SizedBox(
                height: 16,
              ),

              //Just a Date
              CustomRadioTile<String>(
                subTittle:const Text('Find each other for friendship'),
                onSubtitleClicked: () {},
                toggleSubtitle: false,
                value: 'just a date',
                groupValue: radioValue,
                tittle:'Just a Date',
                onChanged: (val) {
                  setState(() {
                    radioValue = val;
                  });
                },
              ),

              const SizedBox(
                height: 16,
              ),

              //Causal Relationship
              CustomRadioTile<String>(
                subTittle:const Text('Go on dates and spend time together'),
                onSubtitleClicked: () {},
                toggleSubtitle: false,
                value: 'causal relationship',
                groupValue: radioValue,
                tittle:'Causal Relationship',
                onChanged: (val) {
                  setState(() {
                    radioValue = val;
                  });
                },
              ),

              const SizedBox(
                height: 16,
              ),

              //Serious Relationship
              CustomRadioTile<String>(
                subTittle:const Text('Committed to each other and looking at a future together'),
                onSubtitleClicked: () {},
                toggleSubtitle: false,
                value: 'serious relationship',
                groupValue: radioValue,
                tittle:'Serious Relationship',
                onChanged: (val) {
                  setState(() {
                    radioValue = val;
                  });
                },
              ),

              const SizedBox(
                height: 16,
              ),

              //Marriage
              CustomRadioTile<String>(
                subTittle:const Text('Having Legally or Formally recognized union'),
                onSubtitleClicked: () {},
                toggleSubtitle: false,
                value: 'marriage',
                groupValue: radioValue,
                tittle:'Marriage',
                onChanged: (val) {
                  setState(() {
                    radioValue = val;
                  });
                },
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Row(
                children: const [
                  Icon(Icons.lock, color: Colors.white),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Text(
                        'This will only be shown to others in the same mode',
                        style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
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
}
