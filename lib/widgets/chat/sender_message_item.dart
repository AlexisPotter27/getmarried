import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/data/models/chat_message.dart';

class SenderMessageItem extends StatefulWidget {
  const SenderMessageItem({Key? key, required this.message}) : super(key: key);
  final ChatMessage message;

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
      child: Text(
        widget.message.text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
