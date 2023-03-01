import 'package:flutter/material.dart';
import 'package:getmarried/constant.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/presentation/screens/registration/onboard.dart';
import 'package:getmarried/widgets/reigistration/custom_radio_tile.dart';
import 'package:getmarried/widgets/reigistration/next_button.dart';

class ChooseModeScreen extends StatefulWidget {
  const ChooseModeScreen({Key? key, required this.onComplete})
      : super(key: key);
  final Function onComplete;

  @override
  State<ChooseModeScreen> createState() => _ChooseModeScreenState();
}

class _ChooseModeScreenState extends State<ChooseModeScreen> {
  String radioValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColour,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Text(
                      'Choose a mode to get started ?',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Get married is for making all kinds of connections!. You will be able to switch modes once you are all setup.',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    //Don't Know
                    CustomRadioTile<String>(
                      subTittle: const Text(
                        "I don't Know",
                      ),
                      onSubtitleClicked: () {},
                      toggleSubtitle: false,
                      value: "don't know",
                      groupValue: radioValue,
                      tittle: "Don't Know",
                      onChanged: (val) {
                        showPromptMessage(context);
                        // setState(() {
                        //   radioValue = val;
                        // });
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    //Just a Date
                    CustomRadioTile<String>(
                      subTittle: const Text('Find each other for friendship'),
                      onSubtitleClicked: () {},
                      toggleSubtitle: false,
                      value: 'just a date',
                      groupValue: radioValue,
                      tittle: 'Just a Date',
                      onChanged: (val) {
                        showPromptMessage(context);

                        // setState(() {
                        //   radioValue = val;
                        // });
                      },
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    //Causal Relationship
                    CustomRadioTile<String>(
                      subTittle:
                          const Text('Go on dates and spend time together'),
                      onSubtitleClicked: () {},
                      toggleSubtitle: false,
                      value: 'causal relationship',
                      groupValue: radioValue,
                      tittle: 'Causal Relationship',
                      onChanged: (val) {
                        showPromptMessage(context);

                        // setState(() {
                        //   radioValue = val;
                        // });
                      },
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    //Serious Relationship
                    CustomRadioTile<String>(
                      subTittle: const Text(
                          'Committed to each other and looking at a future together'),
                      onSubtitleClicked: () {},
                      toggleSubtitle: false,
                      value: 'serious relationship',
                      groupValue: radioValue,
                      tittle: 'Serious Relationship',
                      onChanged: (val) {
                        setState(() {
                          radioValue = val;
                        });
                      },
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    //Marriage
                    CustomRadioTile<String>(
                      subTittle: const Text(
                          'Having Legally or Formally recognized union'),
                      onSubtitleClicked: () {},
                      toggleSubtitle: false,
                      value: 'marriage',
                      groupValue: radioValue,
                      tittle: 'Marriage',
                      onChanged: (val) {
                        setState(() {
                          radioValue = val;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: const [
                        Icon(Icons.lock, color: Colors.white),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: Text(
                          'This will only be shown to others in the same mode',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.white),
                        ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  NextButton(onPressed: () {
                    if (radioValue.isEmpty) {
                      showCustomToast('Please select an option');
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Onboard(),
                      ));
                    }

                    // widget.onComplete();
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

void showPromptMessage(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    content: PromptMessageWidget(),
    backgroundColor: Colors.transparent,
  ));
}

class PromptMessageWidget extends StatelessWidget {
  const PromptMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: primaryColour, borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            child: Image.asset(
              'assets/logo.png',
              height: 40,
              width: 40,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: RichText(
              text: const TextSpan(children: [
                TextSpan(
                    text: 'Get Married App ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
                TextSpan(
                    text:
                        'is the best for those specifically looking to get married. Please visit us again when you are ready to commit. ',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        color: Colors.black)),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
