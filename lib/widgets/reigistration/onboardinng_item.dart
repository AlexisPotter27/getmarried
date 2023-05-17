import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';

class OnboardingItem extends StatefulWidget {
  const OnboardingItem(
      {Key? key, required this.text, required this.header, this.img})
      : super(key: key);
  final String text;
  final String header;
  final String? img;

  @override
  _OnboardingItemState createState() => _OnboardingItemState();
}

class _OnboardingItemState extends State<OnboardingItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          // image:
          //     DecorationImage(image: AssetImage(widget.img), fit: BoxFit.cover),
          ),
      child: Container(
        decoration: const BoxDecoration(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        height: MediaQuery.of(context).size.height * 0.75,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Expanded(child: Center(child: Image.asset(widget.img))),
            Spacer(),
            Text(widget.header,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: primaryColour,
                  fontSize: kIsWeb ? 30 : 25,
                  fontWeight: FontWeight.w600,
                )),
            Text(widget.text,
                style: const TextStyle(
                    fontFamily: 'Poppins', fontSize: 16, color: Colors.white)),
            // SizedBox(
            //   height: 8,
            // ),
          ],
        ),
      ),
    );
  }
}
