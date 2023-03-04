import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';

class SenderMessageItem extends StatefulWidget {
  const SenderMessageItem({Key? key}) : super(key: key);

  @override
  State<SenderMessageItem> createState() => _SenderMessageItemState();
}

class _SenderMessageItemState extends State<SenderMessageItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2 + 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10)),
          color: primaryColour),
      child: const Text(
        'Hello, how are you doing  d dddddd ddd dd ddd dd dd d ?',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
