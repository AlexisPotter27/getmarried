import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';

class CardTile extends StatefulWidget {
  const CardTile({Key? key}) : super(key: key);

  @override
  State<CardTile> createState() => _CardTileState();
}

class _CardTileState extends State<CardTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 0.5
          ),
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 16),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 17,
            backgroundColor: primaryColour,
            child: Icon(Icons.star,size: 15,),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Spotlight',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
              Text(
                'See price',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                    fontWeight: FontWeight.w500
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}