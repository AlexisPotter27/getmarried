import 'package:flutter/material.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/widgets/reigistration/form_field.dart';
import 'package:getmarried/widgets/reigistration/next_button.dart';
import 'package:getmarried/widgets/reigistration/not_sure_widget.dart';

class AboutYouScreen extends StatefulWidget {
  const AboutYouScreen(
      {Key? key, required this.onComplete, required this.onPrev})
      : super(key: key);
  final Function(String? about) onComplete;
  final Function onPrev;

  @override
  State<AboutYouScreen> createState() => _AboutYouScreenState();
}

class _AboutYouScreenState extends State<AboutYouScreen> {
  final _aboutController = TextEditingController();

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
                'Tell us more about yourself?',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 16,
              ),
              /* const Text(
                'Other people looking for relationship love to see bio that shows who you are',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
              ),
              const SizedBox(
                height: 16,
              ),*/
              CustomFormField(
                focusNode: FocusNode(),
                maxLines: 9,
                controller: _aboutController,
                keyboardType: TextInputType.text,
                hintText: 'Enter more about you',
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: NextButton(
                  isNext: false,
                  onPressed: () {
                    widget.onPrev();
                  }),
            ),

            GestureDetector(
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                widget.onComplete(null);
              },
            ),
            NextButton(onPressed: () {
              if (_aboutController.text.isEmpty) {
                showCustomToast('Tell us about you');
              } else {
                widget.onComplete(_aboutController.text);
              }
            }),
          ],
        ),
        const NotSureWidget(
          tittle: 'Not sure what to write ?',
          icon: Icons.person,
        )
      ],
    );
  }
}
