import 'package:flutter/material.dart';
import 'package:getmarried/data/models/chat_message.dart';

class ReceiverMessageItem extends StatefulWidget {
  const ReceiverMessageItem({Key? key, required this.message}) : super(key: key);
  final ChatMessage message;


  @override
  State<ReceiverMessageItem> createState() => _ReceiverMessageItemState();
}

class _ReceiverMessageItemState extends State<ReceiverMessageItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2 + 20),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10)),
          color: Colors.grey.shade200),
      child:  Text(
       widget.message.text,
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
