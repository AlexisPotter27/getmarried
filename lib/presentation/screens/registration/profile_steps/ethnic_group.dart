import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/widgets/reigistration/custom_radio_tile.dart';
import 'package:getmarried/widgets/reigistration/next_button.dart';

class EthnicGroup extends StatefulWidget {
  const EthnicGroup({Key? key, required this.onComplete, required this.onPrev})
      : super(key: key);
  final Function(String? ethnicity) onComplete;
  final Function onPrev;

  @override
  State<EthnicGroup> createState() => _EthnicGroupState();
}

class _EthnicGroupState extends State<EthnicGroup> {
  String value = '';
  late List<String> allEthnicGroup;

  @override
  void initState() {
    super.initState();
    allEthnicGroup = ethnic;
  }

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
                Icons.people,
                size: 25,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Ethnic group',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: allEthnicGroup.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Column(
                    children: [
                      CustomRadioTile<String>(
                        onSubtitleClicked: () {},
                        toggleSubtitle: false,
                        value: allEthnicGroup[index],
                        groupValue: value,
                        tittle: allEthnicGroup[index],
                        onChanged: (val) {
                          setState(() {
                            value = val;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            NextButton(
                isNext: false,
                onPressed: () {
                  widget.onPrev();
                }),
            GestureDetector(
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onTap: () {
                widget.onComplete(null);
              },
            ),
            NextButton(onPressed: () {
              if (value.isEmpty) {
                showCustomToast('Select an option');
              } else {
                widget.onComplete(value);
              }
            }),
          ],
        )
      ],
    );
  }
}
