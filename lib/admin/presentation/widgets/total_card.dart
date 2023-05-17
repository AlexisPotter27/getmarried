import 'package:flutter/material.dart';

class TotalCard extends StatefulWidget {
  const TotalCard({Key? key, required this.tittle, required this.value, required this.icon, this.gradient})
      : super(key: key);
  final String tittle;
  final String value;
  final Widget icon;
  final Gradient? gradient;

  @override
  State<TotalCard> createState() => _TotalCardState();
}

class _TotalCardState extends State<TotalCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: widget.gradient ?? LinearGradient(
            end: Alignment.centerLeft,
            begin: Alignment.centerRight,
            colors: [
              Colors.cyan.shade300,
              Colors.cyan.shade300,
              Colors.cyan.shade400,
              Colors.cyan,
            ]),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        widget.icon,
        SizedBox(height: 16,),
        Text(widget.tittle,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),
        SizedBox(height: 8,),
        Text(widget.value,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),),




      ],),
    );
  }
}
