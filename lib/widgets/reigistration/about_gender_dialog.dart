import 'package:flutter/material.dart';
import 'package:getmarried/widgets/primary_button.dart';

import '../../constant.dart';

class AboutGenderSheet extends StatefulWidget {
  const AboutGenderSheet({Key? key, required this.options}) : super(key: key);
  final List options;

  @override
  State<AboutGenderSheet> createState() => _AboutGenderSheetState();
}

class _AboutGenderSheetState extends State<AboutGenderSheet> {

  String radioValue = 'Man';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children:  [
                  GestureDetector(
                    child:const Icon(
                      Icons.arrow_back_ios,
                      size: 18,
                    ),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),
                  const  SizedBox(
                    width: 16,
                  ),
                  const  Text(
                    'Add more about your gender',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        wordSpacing: 2),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              'You can choose whether to show this on your profile on the next  step',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.black54,),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
              itemCount: widget.options.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: RadioListTile<String>(
                        value: widget.options[index],
                        contentPadding: EdgeInsets.zero,
                        groupValue: radioValue,
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: Text(widget.options[index],style: const TextStyle(fontWeight: FontWeight.w400),),
                        activeColor: primaryColour,
                        onChanged: (val) {
                          setState(() {
                            radioValue = val!;
                          });
                        }),
                  ),
                  const Divider(),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 13),
              child: Row(
                children: const [
                  Expanded(
                      child: Text(
                    'Tell us if we are missing something',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  )),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 16,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            PrimaryButton(
                child: const Text('Save and close'), onPressed: () {
              Navigator.pop(context);

            }),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
