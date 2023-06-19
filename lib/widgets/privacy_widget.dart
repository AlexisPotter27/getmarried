import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';


class PrivacyWidget extends StatefulWidget {
  const PrivacyWidget({Key? key}) : super(key: key);

  @override
  State<PrivacyWidget> createState() => _PrivacyWidgetState();
}

class _PrivacyWidgetState extends State<PrivacyWidget> {
  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 35,
      backgroundColor: Colors.white,
      child: Icon(
        Icons.lock,
        color: primaryColour,
        size: 30,
      ),
    );
  }
}
