import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getmarried/constant.dart';
import 'package:getmarried/widgets/date/children_bottomsheet.dart';
import 'package:getmarried/widgets/date/drink_bottomsheet.dart';
import 'package:getmarried/widgets/date/education_bottomsheet.dart';
import 'package:getmarried/widgets/date/excercise_bottomsheet.dart';
import 'package:getmarried/widgets/date/height_bottomsheet.dart';
import 'package:getmarried/widgets/date/needs_bottomsheet.dart';
import 'package:getmarried/widgets/date/religion_bottomsheet.dart';
import 'package:getmarried/widgets/date/settings_tile.dart';
import 'package:getmarried/widgets/date/star_sign_bottomsheet.dart';
import 'package:getmarried/widgets/date/topics_bottomsheet.dart';

class AdvancedFiltersScreen extends StatefulWidget {
  const AdvancedFiltersScreen({Key? key}) : super(key: key);

  @override
  State<AdvancedFiltersScreen> createState() => _AdvancedFiltersScreenState();
}

class _AdvancedFiltersScreenState extends State<AdvancedFiltersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title:  Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 40,
              width: 50,
            ),
            const Text(
              'Advanced filters',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: primaryColour,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    SettingsTile(
                      text: 'Verified profiles only',
                      prefixIcon: const Icon(
                        Icons.health_and_safety_rounded,
                        color: Colors.black45,
                      ),
                      suffixIcon: SizedBox(
                          height: 25,
                          child: Transform.scale(
                            scale: 0.8,
                            child: CupertinoSwitch(
                              value: true,
                              onChanged: (val) {},
                              activeColor: primaryColour,
                            ),
                          )),
                      onPressed: () {},
                      tittle: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Have they verified themselves ?',
                              style: TextStyle(fontSize: 13),
                            ),
                            Text(
                              'What\'s this',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SettingsTile(
                      text: 'Add this filter',
                      suffixIcon: Icon(
                        Icons.add,
                        color: Colors.grey.shade300,
                      ),
                      prefixIcon: Transform.rotate(
                          angle: 50,
                          child: const Icon(
                            Icons.straighten,
                            color: Colors.black45,
                          )),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => const HeightBottomSheet(),
                            backgroundColor: Colors.transparent);
                      },
                      tittle: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'What is their height ?',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SettingsTile(
                      text: 'Add this filter',
                      suffixIcon: Icon(
                        Icons.add,
                        color: Colors.grey.shade300,
                      ),
                      prefixIcon: Transform.rotate(
                          angle: 50,
                          child: const Icon(
                            Icons.fitness_center,
                            color: Colors.black45,
                          )),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => const ExerciseBottomSheet(),
                            backgroundColor: Colors.transparent);
                      },
                      tittle: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Do they exercise ?',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SettingsTile(
                      text: 'Add this filter',
                      suffixIcon: Icon(
                        Icons.add,
                        color: Colors.grey.shade300,
                      ),
                      prefixIcon: const Icon(
                        Icons.school_outlined,
                        color: Colors.black45,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => const EducationBottomSheet(),
                            backgroundColor: Colors.transparent);
                      },
                      tittle: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'What is their education ?',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SettingsTile(
                      text: 'Add this filter',
                      suffixIcon: Icon(
                        Icons.add,
                        color: Colors.grey.shade300,
                      ),
                      prefixIcon: const Icon(
                        Icons.wine_bar,
                        color: Colors.black45,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => const DrinkBottomSheet(),
                            backgroundColor: Colors.transparent);
                      },
                      tittle: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Do they drink ?',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SettingsTile(
                      text: 'Add this filter',
                      suffixIcon: Icon(
                        Icons.add,
                        color: Colors.grey.shade300,
                      ),
                      prefixIcon: Transform.rotate(
                          angle: 50,
                          child: const Icon(
                            Icons.smoking_rooms,
                            color: Colors.black45,
                          )),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => const DrinkBottomSheet(),
                            backgroundColor: Colors.transparent);
                      },
                      tittle: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Do they smoke ?',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SettingsTile(
                      text: 'Add this filter',
                      suffixIcon: Icon(
                        Icons.add,
                        color: Colors.grey.shade300,
                      ),
                      prefixIcon: Transform.rotate(
                          angle: 50,
                          child: const Icon(
                            Icons.search,
                            color: Colors.black45,
                          )),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => const NeedsBottomSheet(),
                            backgroundColor: Colors.transparent);
                      },
                      tittle: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'What is do you want from your  get married?',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SettingsTile(
                      text: 'Add this filter',
                      suffixIcon: Icon(
                        Icons.add,
                        color: Colors.grey.shade300,
                      ),
                      prefixIcon: Transform.rotate(
                          angle: 50,
                          child: const Icon(
                            Icons.baby_changing_station,
                            color: Colors.black45,
                          )),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => const ChildrenBottomsheet(),
                            backgroundColor: Colors.transparent);
                      },
                      tittle: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Do they have children ?',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SettingsTile(
                      text: 'Add this filter',
                      suffixIcon: Icon(
                        Icons.add,
                        color: Colors.grey.shade300,
                      ),
                      prefixIcon: Transform.rotate(
                          angle: 50,
                          child: const Icon(
                            Icons.diamond_outlined,
                            color: Colors.black45,
                          )),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => const StarSignBottomSheet(),
                            backgroundColor: Colors.transparent);
                      },
                      tittle: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'What is their start sign ?',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SettingsTile(
                      text: 'Add this filter',
                      suffixIcon: Icon(
                        Icons.add,
                        color: Colors.grey.shade300,
                      ),
                      prefixIcon: const Icon(
                        Icons.account_balance_rounded,
                        color: Colors.black45,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => const TopicsBottomSheet(),
                            backgroundColor: Colors.transparent);
                      },
                      tittle: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'What are their topics like  ?',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SettingsTile(
                      text: 'Add this filter',
                      suffixIcon: Icon(
                        Icons.add,
                        color: Colors.grey.shade300,
                      ),
                      prefixIcon: Transform.rotate(
                          angle: 50,
                          child: const Icon(
                            Icons.sign_language_outlined,
                            color: Colors.black45,
                          )),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => const ReligionBottomSheet(),
                            backgroundColor: Colors.transparent);
                      },
                      tittle: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'What is their religion ?',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 5,
                right: 0,
                left: 0,
                child: Center(
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: primaryColour,
                        primary: Colors.black),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text('Upgrade for advanced filters'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
