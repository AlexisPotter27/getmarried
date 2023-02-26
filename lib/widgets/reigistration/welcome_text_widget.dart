import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class WelcomeTextWidget extends StatelessWidget {
  const WelcomeTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Align(
          alignment: Alignment.center,
            child: Text("WELCOME!",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,)),

        Text("We're excited that you found us and want to GET MARRIED!",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500, color: Colors.white),),
        SizedBox(
          height: 16,
        ),
        Text(
          'Here we treat everyone with kindness and respect, no matter their race, religion, nationality, ethnicity,skin, color, ability, size, sex, gender, identity or sexual orientation.',
            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500, color: Colors.white)
        ),
        SizedBox(
          height: 10,
        ),
        Text.rich(
            style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500, color: Colors.white),
            TextSpan(children: [
          TextSpan(text: 'In our mission to actively Get married safe and inclusive, we ask you to join us by adhering to our ', style: TextStyle(color: Colors.white)),
          TextSpan(text: 'guidelines',style: TextStyle(decoration: TextDecoration.underline,fontWeight: FontWeight.bold, color: Colors.white)),
        ])),
        SizedBox(
          height: 16,
        ),
        Text('And remember: We always got your back!',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500, color: Colors.white)),
        SizedBox(
          height: 16,
        ),
        Text('With love, The GetMarriedApp Team',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500, color: Colors.white)),
      ],
    );
  }
}
