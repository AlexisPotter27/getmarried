import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/constants/storage_keys.dart';
import 'package:getmarried/helper/storage_helper.dart';
import 'package:getmarried/presentation/screens/registration/signin_screen.dart';
import 'package:getmarried/widgets/reigistration/onboading_button.dart';
import 'package:getmarried/widgets/reigistration/onboardinng_item.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;
  double progress = 0.5;

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/jpeg/getmarried.jpeg'))),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(1),
                  Colors.black.withOpacity(1)
                ])),
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
              child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      if (index < _currentIndex) {
                        progress -= 0.5;
                      } else {
                        progress += 0.5;
                      }
                      _currentIndex = index;
                    });
                  },
                  children: const [
                    OnboardingItem(
                      img: 'assets/connected1.png',
                      header: 'Getmarried App',
                      text: introText,
                    ),
                  ]),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Indicator(
                          //   seledtedIndex: _currentIndex,
                          //   items_count: 1,
                          // ),
                          Spacer(),
                          OnboardingButton(
                              onTap: () {
                                switchPage();
                              },
                              progress: progress),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ));
  }

  void switchPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SigninScreen(),
        ));
    StorageHelper.setBoolean(StorageKeys.isFirstTime, false);

    // setState(() {
    //   _pageController.jumpToPage(_currentIndex + 1);
    // });
  }
}
