import 'package:flutter/material.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/widgets/reigistration/form_field.dart';
import 'package:getmarried/widgets/reigistration/next_button.dart';




class EmailScreen extends StatefulWidget {
  const EmailScreen({Key? key, required this.onComplete, required this.onPrev}) : super(key: key);
  final Function(String? email) onComplete;
  final Function onPrev;

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final _emailController = TextEditingController();

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
                'What is your email ?',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'We use this to recover your account if you cannot log in.',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomFormField(
                focusNode: FocusNode(),
                controller: _emailController,
                hintText: 'Add recovery email',
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
              onTap: () {
                widget.onComplete(null);
              },
              child: const Text(
                'Skip',
                style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
              ),
            ),
            NextButton(onPressed: () {
              if(_emailController.text.isEmpty){
                showCustomToast('Enter email');
              }else{
                widget.onComplete(_emailController.text);

              }
            }),
          ],
        )
      ],
    );
  }
}
