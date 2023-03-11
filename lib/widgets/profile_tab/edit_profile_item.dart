import 'package:flutter/material.dart';
import 'package:getmarried/models/user.dart';

class EditProfileItem extends StatefulWidget {
  const EditProfileItem({Key? key, required this.value, required this.selected})
      : super(key: key);
  final String value;
  final bool selected;

  @override
  State<EditProfileItem> createState() => _EditProfileItemState();
}

class _EditProfileItemState extends State<EditProfileItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Container(
        child: Center(
            child: Text(
          widget.value,
          style: TextStyle(fontWeight: FontWeight.w500),
        )),
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300, width: 1)),
      ),
    );
  }
}
