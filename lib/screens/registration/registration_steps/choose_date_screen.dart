import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../widgets/custom_checkbox.dart';
import '../../../widgets/next_button.dart';

class ChooseDateScreen extends StatefulWidget {
  const ChooseDateScreen({Key? key, required this.onComplete})
      : super(key: key);
  final Function onComplete;

  @override
  State<ChooseDateScreen> createState() => _ChooseDateScreenState();
}

class _ChooseDateScreenState extends State<ChooseDateScreen> {
  bool showOnProfile = true;
  final List gender = ['Men', 'Women', ];
   List selctedOptions = ['Men', 'Women', ];

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
                'Who would you like to date ?',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'You can choose more than one answer and change any time.',
                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              /*Row(
                children: [
                  CupertinoSwitch(
                    value: showOnProfile,
                    onChanged: (val) {
                      setState(() {
                        showOnProfile = val;
                        if(val){
                          selctedOptions.clear();
                          selctedOptions.addAll(gender);
                        }
                      });
                    },
                    activeColor: Colors.black,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'I am open to dating everyone',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  )
                ],
              ),*/
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: gender.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Column(
                    children: [
                      CustomCheckbox(
                        text: gender[index],
                        isChecked: selctedOptions.contains(gender[index]),
                        onChanged: (val) {
                     setState(() {
                       if (!selctedOptions.contains(gender[index])) {
                         selctedOptions.add(gender[index]);
                       }else{
                         selctedOptions.remove(gender[index]);
                       }
                     });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              )
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
                    'You will only be shown to people looking to date your gender.',
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
                  )),
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
