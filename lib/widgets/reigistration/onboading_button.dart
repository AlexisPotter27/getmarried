import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';

class OnboardingButton extends StatelessWidget {
  const OnboardingButton(
      {Key? key, required this.onTap, required this.progress})
      : super(key: key);

  final VoidCallback onTap;

  final double progress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: SizedBox(
        height: 70,
        width: 70,
        child: Stack(
          fit: StackFit.loose,
          children: [
            // SizedBox(
            //   height: 70,
            //   width: 70,
            //   child: CircularProgressIndicator(
            //     backgroundColor: Colors.grey.shade200,
            //     color: primaryColour,
            //     value: progress,
            //   ),
            // ),
            Center(
                child: CircleAvatar(
              radius: 30,
              backgroundColor: primaryColour,
              child: const Center(
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
