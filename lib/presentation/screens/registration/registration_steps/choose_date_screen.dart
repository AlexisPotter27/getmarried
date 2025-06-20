import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';
import 'package:getmarried/widgets/reigistration/about_gender_dialog.dart';
import 'package:getmarried/widgets/reigistration/custom_radio_tile.dart';
import 'package:getmarried/widgets/reigistration/next_button.dart';

class ChooseDateScreen extends StatefulWidget {
  const ChooseDateScreen(
      {Key? key, required this.onComplete, required this.onPrev})
      : super(key: key);
  final Function(String date) onComplete;
  final Function onPrev;

  @override
  State<ChooseDateScreen> createState() => _ChooseDateScreenState();
}

List<String> options = [
  'Men',
  'Women',
];

class _ChooseDateScreenState extends State<ChooseDateScreen> {
  String radioValue = '';

  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    radioValue = getIt.get<CacheCubit>().user!.gender == 'Man' ? 'Women' : 'Men';
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
              const Text(
                "I'm looking for...",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 30,
              ),
              ListView.builder(
                itemCount: options.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => Column(
                  children: [
                    CustomRadioTile<String>(
                      /*subTittle: Row(
                        children: const [
                          Text('Add more about your gender'),
                          Icon(Icons.keyboard_arrow_down)
                        ],
                      ),*/
                      onSubtitleClicked: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) => AboutGenderSheet(
                            options: aboutOptions(options[index]),
                          ),
                        );
                      },
                      toggleSubtitle: true,
                      value: options[index],
                      groupValue: radioValue,
                      tittle: options[index],
                      onChanged: (val) {
                        setState(() {
                          radioValue = val;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    )
                  ],
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: NextButton(
                  isNext: false,
                  onPressed: () {
                    widget.onPrev();
                  }),
            ),
            NextButton(onPressed: () {
              widget.onComplete(radioValue);
            }),
          ],
        )
      ],
    );
  }

  List<String> aboutOptions(String category) {
    if (category == 'Man') {
      return maleGenders;
    } else if (category == 'Woman') {
      return femaleGenders;
    } else {
      return nonBinaryGenders;
    }
  }
}
