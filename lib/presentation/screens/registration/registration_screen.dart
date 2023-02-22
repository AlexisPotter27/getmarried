import 'package:flutter/material.dart';
import 'package:getmarried/constant.dart';
import 'package:getmarried/presentation/screens/registration/registration_steps/add_photos_screen.dart';
import 'package:getmarried/presentation/screens/registration/registration_steps/birthday_screen.dart';
import 'package:getmarried/presentation/screens/registration/registration_steps/choose_date_screen.dart';
import 'package:getmarried/presentation/screens/registration/registration_steps/choose_mode.dart';
import 'package:getmarried/presentation/screens/registration/registration_steps/email_screen.dart';
import 'package:getmarried/presentation/screens/registration/registration_steps/first_name_screen.dart';
import 'package:getmarried/presentation/screens/registration/registration_steps/gender_screen.dart';
import 'build_profile_onboard.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _pageController = PageController();
  double progress = 0.11;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.indigoAccent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              LinearProgressIndicator(
                minHeight: 5,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.black),
                backgroundColor: Colors.white.withOpacity(0.3),
                value: progress,
              ),
              Expanded(
                  child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  FirstNameScreen(onComplete: () {
                    switchPage(1);
                  }),
                  AddPhotosScreen(onComplete: () {
                    switchPage(2);
                  }),
                  BirthdayScreen(onComplete: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                          actionsPadding: const EdgeInsets.all(16),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                'You are 29',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                  'Make sure this is your correct age as you cant change this later'),
                            ],
                          ),
                          actions: [
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);

                              },
                              child: const Text(
                                'CANCEL',
                                style: TextStyle(color: primaryColour),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                                switchPage(3);
                              },
                              child: const Text(
                                'CONFIRM',
                                style: TextStyle(color: primaryColour),
                              ),
                            ),
                          ]),
                    );
                    // switchPage(3);
                  }),
                  GenderScreen(
                    onComplete: () {
                      switchPage(4);
                    },
                  ),
                  /*ShowGenderScreen(
                    onComplete: () {
                      switchPage(5);
                    },
                  ),*/
                  ChooseModeScreen(
                    onComplete: () {
                      switchPage(5);
                    },
                  ),
                  ChooseDateScreen(
                    onComplete: () {
                      switchPage(6);
                    },
                  ),
                  /*ChooseReletionShipType(
                    onComplete: () {
                      switchPage(8);
                    },
                  ),*/
                  EmailScreen(
                    onComplete: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const BuildProfileOnboard(),
                      ));
                    },
                  )
                  // InterestScreen(),
                  // HeightScreen(),
                  // BirthdayScreen(),
                  // AddPhotosScreen(),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  void switchPage(int to) {
    setState(() {
      _pageController.jumpToPage(to);
      progress += 0.12;
    });
  }
}
