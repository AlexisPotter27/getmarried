import 'package:flutter/material.dart';
import 'package:getmarried/constant.dart';

class HeightBottomSheet extends StatefulWidget {
  const HeightBottomSheet({Key? key}) : super(key: key);

  @override
  State<HeightBottomSheet> createState() => _HeightBottomSheetState();
}

class _HeightBottomSheetState extends State<HeightBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: Colors.black,
                    )),
                const Text(
                  'Add this filter',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Any height is just fine',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            RangeSlider(
              values: const RangeValues(0, 10),
              onChanged: (val) {},
              activeColor: primaryColour,
              inactiveColor: primaryColour.withOpacity(0.5),
              min:0 ,
              max: 20,
            )
          ],
        ),
      ),
    );
  }
}
