import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getmarried/widgets/reigistration/next_button.dart';

class PartnersHeight extends StatefulWidget {
  const PartnersHeight(
      {Key? key, required this.onComplete, required this.onPrev})
      : super(key: key);
  final Function(String? height) onComplete;
  final Function onPrev;

  @override
  State<PartnersHeight> createState() => _PartnersHeightState();
}

class _PartnersHeightState extends State<PartnersHeight> {
  final heights = [
    ''' 5' 1" ''',
    ''' 5' 2" ''',
    ''' 5' 3" ''',
    ''' 5' 4" ''',
    ''' 5' 5" ''',
    ''' 5' 6" ''',
    ''' 5' 7" ''',
    ''' 5' 8" ''',
    ''' 5' 9" ''',
    ''' 5' 10" ''',
    ''' 5' 11" ''',
    ''' 5' 12" ''',
    ''' 6' 0" ''',
    ''' 6' 1" ''',
    ''' 6' 2" ''',
    ''' 6' 3" ''',
    ''' 6' 4" ''',
    ''' 6' 5" ''',
    ''' 6' 6" ''',
    ''' 6' 7" '''
  ];
  int currentIndex = 0;

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
                'What is  your ideal partners height ?',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 300,
                child: CupertinoPicker(
                    onSelectedItemChanged: (val) {
                      setState(() {
                        currentIndex = val;
                      });
                    },
                    itemExtent: 40,
                    looping: true,
                    selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                      background: CupertinoColors.white.withOpacity(0.5),
                    ),
                    scrollController:
                        FixedExtentScrollController(initialItem: 1),
                    children: List.generate(
                      heights.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Visibility(
                                visible: false,
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 16,
                                )),
                            Text(
                              heights[index],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    )),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(

              mainAxisSize: MainAxisSize.min,

              children: [
                NextButton(
                    isNext: false,
                    onPressed: () {
                      widget.onPrev();
                    }),
                GestureDetector(
                    onTap: () {
                      widget.onComplete(null);
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
              ],
            ),
            NextButton(onPressed: () {
              widget.onComplete(heights[currentIndex]);
            }),
          ],
        )
      ],
    );
  }
}
