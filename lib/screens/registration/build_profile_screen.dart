

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getmarried/screens/registration/profile_steps/about_you_screen.dart';
import 'package:getmarried/screens/registration/profile_steps/children_concent_screen.dart';
import 'package:getmarried/screens/registration/profile_steps/drinking_screen.dart';
import 'package:getmarried/screens/registration/profile_steps/education_status_screen.dart';
import 'package:getmarried/screens/registration/profile_steps/height_screen.dart';
import 'package:getmarried/screens/registration/profile_steps/interest.dart';
import 'package:getmarried/screens/registration/profile_steps/polotical_leanings.dart';
import 'package:getmarried/screens/registration/profile_steps/religion_screen.dart';
import 'package:getmarried/screens/registration/profile_steps/smoking_screen.dart';
import 'package:getmarried/screens/registration/profile_steps/star_sign_screen.dart';
import 'package:getmarried/screens/registration/profile_steps/work_out.dart';
import 'package:getmarried/screens/registration/welcome_screen.dart';

import '../../constant.dart';

class BuildProfileScreen extends StatefulWidget {
  const BuildProfileScreen({Key? key}) : super(key: key);

  @override
  State<BuildProfileScreen> createState() => _BuildProfileScreenState();
}

class _BuildProfileScreenState extends State<BuildProfileScreen> {
  final _pageController = PageController();
  double progress = 0.09;

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
                backgroundColor: Colors.black.withOpacity(0.3),
                value: progress,
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  InterestScreen(onComplete: () {
                    switchPage(1);
                  }),
                  HeightScreen(onComplete: () {
                    switchPage(2);
                  }),
                  WorkoutScreen(onComplete: () {
                    switchPage(3);
                  }),
                  StarSignScreen(onComplete: () {
                    switchPage(4);
                  }),
                  EducationStatus(onComplete: () {
                    switchPage(5);
                  }),
                  DrinkingScreen(onComplete: () {
                    switchPage(6);
                  }),
                  SmokingScreen(onComplete: () {
                    switchPage(7);
                  }),
                  ChildrenConsentScreen(onComplete: () {
                    switchPage(8);
                  }),
                  ReligionScreen(onComplete: () {
                    switchPage(9);
                  }),
                  PoliticalLeaningsscreen(onComplete: () {
                    switchPage(10);
                  }),
                  AboutYouScreen(onComplete: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const WelcomeScreen(),));
                  })
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
      progress += 0.091;
    });
  }
}
