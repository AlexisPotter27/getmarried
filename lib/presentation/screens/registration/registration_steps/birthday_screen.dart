import 'package:flutter/material.dart';
import 'package:getmarried/widgets/reigistration/birth_date_widget.dart';
import 'package:getmarried/widgets/reigistration/next_button.dart';


class BirthdayScreen extends StatefulWidget {
   const BirthdayScreen({Key? key, required this.onComplete, required this.onPrev}) : super(key: key);
  final Function onComplete;
  final Function onPrev;


  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

List options = ['Man', 'Woman',];
String radioValue = 'Man';

class _BirthdayScreenState extends State<BirthdayScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              SizedBox(
                height: 20,
              ),
              Text(
                'When is your birthday ?',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              BirthDateWidget()
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Row(
                children:  [
                  NextButton(
                      icon: const Icon(Icons.arrow_back_ios,size: 16,color: Colors.black,),
                      onPressed: () {
                        widget.onPrev();
                      }),
                  const Icon(Icons.lock, color: Colors.white),
                  const   SizedBox(
                    width: 5,
                  ),
                  const  Expanded(
                      child: Text(
                    'We only show your age to potential matches, not your birthday',
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
                  ))
                ],
              ),
            ),
            const SizedBox(
              width: 5,
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
