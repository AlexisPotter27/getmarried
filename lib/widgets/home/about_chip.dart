import 'package:flutter/material.dart';

class AboutChip extends StatelessWidget {
  const AboutChip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label:Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.school_outlined,size: 16,),
          SizedBox(width: 8,),
          Text('Label',style: TextStyle(fontSize: 13),),
        ],
      ),
      backgroundColor: Colors.indigo.shade200,
    );
  }
}
