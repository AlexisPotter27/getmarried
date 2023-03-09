import 'package:flutter/material.dart';

class AboutChip extends StatelessWidget {
  const AboutChip({Key? key, required this.label}) : super(key: key);
 final  String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label:Row(
        mainAxisSize: MainAxisSize.min,
        children:  [
          const Icon(Icons.school_outlined,size: 16,),
          const SizedBox(width: 8,),
          Text(label,style:const TextStyle(fontSize: 13),),
        ],
      ),
      backgroundColor: Colors.indigo.shade200,
    );
  }
}
