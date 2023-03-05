import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';


class NotSureWidget extends StatefulWidget {
  const NotSureWidget({Key? key, this.tittle, this.subtittle, this.icon}) : super(key: key);
  final String? tittle;
  final String? subtittle;
  final IconData? icon;

  @override
  State<NotSureWidget> createState() => _NotSureWidgetState();
}

class _NotSureWidgetState extends State<NotSureWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration:  BoxDecoration(color: primaryColour,borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
            child:  Icon(widget.icon??Icons.folder,color: Colors.white,),),
          const SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
            Text(widget.tittle ??'Not sure you want to upload ?'),
            Text(widget.subtittle ??'Check out our guidelines',style: const TextStyle(decoration: TextDecoration.underline,fontWeight: FontWeight.bold),),

          ],)
        ],
      ),
    );
  }
}
