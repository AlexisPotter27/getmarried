import 'package:flutter/material.dart';

class AboutChip extends StatelessWidget {
  const AboutChip({Key? key, required this.label, this.bgColor}) : super(key: key);
 final  String label;
 final  Color? bgColor;

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
      backgroundColor:bgColor ?? Colors.indigo.shade200,
    );
  }
}
