import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Color colour;
  final Color textcolour;
  final String title;
  final VoidCallback ontap;

  const Button({required this.colour, required this.title,required this.ontap,required this.textcolour});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 40,

        decoration: BoxDecoration(
            color: colour,
          borderRadius: BorderRadius.all(Radius.circular(50))

        ),
        child: Center(
          child:Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,
              color: textcolour,),
          ),
        )
      ),
    );
  }
}
