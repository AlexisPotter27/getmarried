import 'package:flutter/material.dart';
import 'package:getmarried/helper/toastMessage.dart';
import 'package:getmarried/widgets/reigistration/form_field.dart';
import 'package:getmarried/widgets/reigistration/next_button.dart';



class FirstNameScreen extends StatefulWidget {
  const FirstNameScreen({Key? key, required this.onComplete}) : super(key: key);
 final Function onComplete;

  @override
  State<FirstNameScreen> createState() => _FirstNameScreenState();
}

class _FirstNameScreenState extends State<FirstNameScreen> {
  final _firstNameController = TextEditingController();

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
                'What is your first name ?',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'You wont be able to change this later.',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,  color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomFormField(
                focusNode: FocusNode(),
                controller: _firstNameController,
                hintText: 'Add your first name',
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                Icon(Icons.remove_red_eye,  color: Colors.white),
                SizedBox(width: 5,),
                Text('This will be shown on your profile',style: TextStyle(fontWeight: FontWeight.w500,  color: Colors.white),)
              ],
            ),
            NextButton(onPressed: () {
              if(_firstNameController.text.isEmpty){
                ToastMessage.showToast('Please enter your name!');
              }else{
                widget.onComplete();
              }
            }),
          ],
        )
      ],
    );
  }
}
