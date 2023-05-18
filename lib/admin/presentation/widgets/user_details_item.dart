import 'package:flutter/material.dart';

class UserDetailsItem extends StatefulWidget {
  const UserDetailsItem({Key? key, required this.tittle, required this.value})
      : super(key: key);
  final String tittle;
  final String value;

  @override
  State<UserDetailsItem> createState() => _UserDetailsItemState();
}

class _UserDetailsItemState extends State<UserDetailsItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.tittle),
        SizedBox(
          height: 10,
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade300),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
              child: Text(widget.value),
            )),
      ],
    );
  }
}
