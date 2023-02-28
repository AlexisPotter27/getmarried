import 'package:flutter/material.dart';
import 'package:getmarried/widgets/chat/receiver_message_item.dart';
import 'package:getmarried/widgets/chat/sender_message_item.dart';

class MessageBox extends StatefulWidget {
  const MessageBox({Key? key, required this.isSender}) : super(key: key);
  final bool isSender;

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: widget.isSender ? Alignment.centerRight : Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: widget.isSender
          ? const SenderMessageItem()
          : const ReceiverMessageItem(),
    );
  }
}
