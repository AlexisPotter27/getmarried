import 'package:flutter/material.dart';

class ReceiverMessageItem extends StatefulWidget {
  const ReceiverMessageItem({Key? key}) : super(key: key);

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
      child: const Text(
        'Am doing great ?',
        style: TextStyle(color: Colors.grey),
      ),
    );
  }
}
