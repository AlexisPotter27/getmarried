import 'package:flutter/material.dart';

class Facebook extends StatelessWidget {
  final Color colour;
  final Color textcolour;
  final String title;
  final VoidCallback ontap;
  final IconData icons ;

  const Facebook({required this.colour, required this.title,required this.ontap,required this.textcolour, required this.icons});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 40,

          decoration: BoxDecoration(
              color: colour,
              borderRadius: const BorderRadius.all(Radius.circular(50))

          ),
          child: Center(
            child:Padding(
              padding: const EdgeInsets.only(left: 16,right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icons,color: Colors.blue,size: 25,),
                  SizedBox(width: 20,),
                  Text(
                    title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,
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