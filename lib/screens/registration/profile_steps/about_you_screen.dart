import 'package:flutter/material.dart';

import '../../../widgets/form_field.dart';
import '../../../widgets/next_button.dart';
import '../../../widgets/not_sure_widget.dart';

class AboutYouScreen extends StatefulWidget {
  const AboutYouScreen({Key? key, required this.onComplete}) : super(key: key);
  final Function onComplete;

  @override
  State<AboutYouScreen> createState() => _AboutYouScreenState();
}

class _AboutYouScreenState extends State<AboutYouScreen> {
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
                'Add more about you?',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Other people looking for relationship love to see bio that shows who you are',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
              ),
              const SizedBox(
                height: 16,
              ),
              CustomFormField(
                focusNode: FocusNode(),
                maxLines: 4,
                hintText: 'Enter more about you',
              )
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
        ),
        const NotSureWidget( tittle: 'Not sure what to write ?',icon: Icons.person,)
      ],
    );
  }
}
