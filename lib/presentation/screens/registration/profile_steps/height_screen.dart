import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getmarried/widgets/reigistration/next_button.dart';


class HeightScreen extends StatefulWidget {
  const HeightScreen({Key? key, required this.onComplete}) : super(key: key);
  final Function onComplete;

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {

  final heights = ['1cm','2cm','3cm','4cm','5cm','6cm','7cm','8cm',];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Expanded(
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,

           children: [
           const SizedBox(
             height: 20,
           ),
           const Icon(
             Icons.straighten,
             size: 25,
             color: Colors.black,
           ),
           const SizedBox(
             height: 10,
           ),
           const Text(
             'What is  your height ?',
             style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
           ),
           const SizedBox(
             height: 20,
           ),
           SizedBox(
             height: 300,
             child: CupertinoPicker(
                 onSelectedItemChanged: (val) {},
                 itemExtent: 40,
                 looping: true,
                 selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                   background: CupertinoColors.white.withOpacity(0.5),
                 ),
                 scrollController: FixedExtentScrollController(initialItem: 1),
                 children: List.generate(heights.length, (index) =>  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children:  [
                        const Visibility(
                            visible: false,
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16,
                            )),
                        Text(
                         heights[index],
                          style:const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),)
                 ),
           )
         ],),
       ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap:(){
                    widget.onComplete();
                  },
                  child: const Text('Skip',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500, ),)),
              NextButton(onPressed: () {
                widget.onComplete();
              }),
            ],
          ),
        )
      ],
    );
  }
}
