import 'package:flutter/material.dart';
import 'package:getmarried/widgets/reigistration/custom_radio_tile.dart';
import 'package:getmarried/widgets/reigistration/next_button.dart';




class ChooseReletionShipType extends StatefulWidget {
  const ChooseReletionShipType({Key? key, required this.onComplete}) : super(key: key);
  final Function onComplete;

  @override
  State<ChooseReletionShipType> createState() => _ChooseReletionShipTypeState();
}

class _ChooseReletionShipTypeState extends State<ChooseReletionShipType> {
  String value = 'Man';

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
                'Choose a mode to  \nget started ?',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Get married is for making all kinds of connections!. You will be able to switch modes once you are all setup.',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),

              const SizedBox(
                height: 16,
              ),
              CustomRadioTile<String>(

                onSubtitleClicked: () {},
                toggleSubtitle: true,
                value: 'relationShip',
                groupValue: value,
                tittle:'A relationship',
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
                value: 'casual',
                groupValue: value,
                tittle:'Something casual',
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
                value: 'unsure',
                groupValue: value,
                tittle:'Not sure yet',
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
                value: 'not_to_show',
                groupValue: value,
                tittle:'Prefer not to say',
                onChanged: (val) {
                  setState(() {
                    value = val;
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
                  Icon(Icons.lock),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: Text(
                        'This will show on your profile unless you are unsure',
                        style: TextStyle(fontWeight: FontWeight.w500),
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
