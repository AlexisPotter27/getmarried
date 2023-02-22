import 'dart:ui';

import 'package:flutter/material.dart';

class LikerItem extends StatefulWidget {
  const LikerItem({Key? key}) : super(key: key);

  @override
  State<LikerItem> createState() => _LikerItemState();
}

class _LikerItemState extends State<LikerItem> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/jpeg/girl.jpeg',
                ),
                fit: BoxFit.cover)),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaY: 5,
            sigmaX: 5,
          ),
          child: Container(
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(16),
                      height: 10,
                      width: 50,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ),
          // child: Image.asset('assets/jpeg/girl.jpeg'),
        ),
      ),
    );
  }
}
