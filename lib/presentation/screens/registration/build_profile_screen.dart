

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/about_you_screen.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/ambitious.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/athletic.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/attractive.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/body_type.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/children_concent_screen.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/creativity.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/drinking_screen.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/drugs.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/education_status_screen.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/ethnic_group.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/height_screen.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/interest.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/monogamy.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/outgoing.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/partners_body_type.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/partners_ethnicity.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/partners_height.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/partners_religion.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/planning_event.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/polotical_leanings.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/relationship.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/religion_screen.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/smoking_screen.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/star_sign_screen.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/starting_and_finishing.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/understanding.dart';
import 'package:getmarried/presentation/screens/registration/profile_steps/work_out.dart';
import 'package:getmarried/presentation/screens/registration/welcome_screen.dart';


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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:  Center(child: Image.asset('assets/ilogo.png', width: 50, height: 50,)),
        elevation: 0,
        backgroundColor: Colors.indigoAccent,
      ),
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
                  PartnersHeight(onComplete: () {
                    switchPage(3);
                  }),
                  WorkoutScreen(onComplete: () {
                    switchPage(4);
                  }),
                  BodyType(onComplete: () {
                    switchPage(5);
                  }),
                  PartnersBodyType(onComplete: () {
                    switchPage(6);
                  }),
                  Attractive(onComplete: () {
                    switchPage(7);
                  }),
                  StarSignScreen(onComplete: () {
                    switchPage(8);
                  }),
                  EducationStatus(onComplete: () {
                    switchPage(9);
                  }),
                  DrinkingScreen(onComplete: () {
                    switchPage(10);
                  }),
                  SmokingScreen(onComplete: () {
                    switchPage(11);
                  }),
                  DrugsScreen(onComplete: () {
                    switchPage(12);
                  }),
                  ChildrenConsentScreen(onComplete: () {
                    switchPage(13);
                  }),
                  ReligionScreen(onComplete: () {
                    switchPage(14);
                  }),
                  PartnersReligion(onComplete: () {
                    switchPage(15);
                  }),
                  PoliticalLeaningsscreen(onComplete: () {
                    switchPage(16);
                  }),
                  EthnicGroup(onComplete: () {
                    switchPage(17);
                  }),
                  PartnersEthnicity(onComplete: () {
                    switchPage(18);
                  }),
                  PlanningEvent(onComplete: () {
                    switchPage(19);
                  }),
                  Understanding(onComplete: () {
                    switchPage(20);
                  }),
                  Outgoing(onComplete: () {
                    switchPage(21);
                  }),
                  Ambitious(onComplete: () {
                    switchPage(22);
                  }),
                  Athletic(onComplete: () {
                    switchPage(23);
                  }),
                  StartingAndFinishing(onComplete: () {
                    switchPage(24);
                  }),
                  Relationship(onComplete: () {
                    switchPage(25);
                  }),
                  Monogamy(onComplete: () {
                    switchPage(26);
                  }),
                  Creativity(onComplete: () {
                    switchPage(27);
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
      progress += 0.021;
    });
  }
}
