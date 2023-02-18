import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/next_button.dart';

class ShowGenderScreen extends StatefulWidget {
  const ShowGenderScreen({Key? key, required this.onComplete}) : super(key: key);
  final Function onComplete;

  @override
  State<ShowGenderScreen> createState() => _ShowGenderScreenState();
}

class _ShowGenderScreenState extends State<ShowGenderScreen> {
  bool showOnProfile = true;

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
              const Text(
                'Show your gender on your profile',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'This is totally up to you whether you are comfortable.',
                style: TextStyle(fontWeight: FontWeight.w500,  color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  CupertinoSwitch(
                    value: showOnProfile,
                    onChanged: (val) {
                      setState(() {
                        showOnProfile = val;
                      });
                    },
                    activeColor: Colors.black,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'Show on your profile',
                    style: TextStyle(fontWeight: FontWeight.w500,  color: Colors.white),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(16)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Shown as:',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: !showOnProfile
                              ? Colors.black
                              : Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                          backgroundColor:
                              !showOnProfile ? Colors.black : Colors.white,
                          shape: StadiumBorder(
                              side: !showOnProfile
                                  ? const BorderSide(color: Colors.black)
                                  : BorderSide.none),
                          primary: !showOnProfile
                              ? Colors.white
                              : Colors.black),
                      child: const Text('Man'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: NextButton(onPressed: () {
              widget.onComplete();
            }),
          ),
        )
      ],
    );
  }
}
