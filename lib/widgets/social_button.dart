import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final Color colour;
  final Color textcolour;
  final String title;
  final double? fontSize;
  final VoidCallback ontap;
  final Icon icons;

  const SocialButton(
      {required this.colour, required this.title, required this.ontap, required this.textcolour, required this.icons,  this.fontSize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          padding: const EdgeInsets.all(10),

          decoration: BoxDecoration(
              color: colour,
              borderRadius: const BorderRadius.all(Radius.circular(50))

          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icons,
                  const SizedBox(width: 10,),
                  Text(
                    title,
                    style: TextStyle(fontSize: fontSize ?? 13, fontWeight: FontWeight.w500,
                      color: textcolour,),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}