import 'package:flutter/material.dart';


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
        color: Colors.black,
        size: 30,
      ),
    );
  }
}
