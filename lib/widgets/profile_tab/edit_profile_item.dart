import 'package:flutter/material.dart';

class EditProfileItem extends StatefulWidget {
  const EditProfileItem({Key? key, required this.value}) : super(key: key);
  final String value;

  @override
  State<EditProfileItem> createState() => _EditProfileItemState();
}

class _EditProfileItemState extends State<EditProfileItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Height'),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
    );
  }
}
