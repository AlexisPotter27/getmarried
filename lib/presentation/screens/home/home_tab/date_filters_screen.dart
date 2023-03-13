import 'package:flutter/material.dart';
import 'package:getmarried/presentation/screens/home/home_tab/advanced_filters_screen.dart';
import 'package:getmarried/presentation/screens/home/profile_tab/languages_screen.dart';
import 'package:getmarried/widgets/home/age_selector_card.dart';
import 'package:getmarried/widgets/home/date_option_card.dart';
import 'package:getmarried/widgets/date/settings_tile.dart';

class DateFiltersScreen extends StatefulWidget {
  const DateFiltersScreen({Key? key}) : super(key: key);

  @override
  State<DateFiltersScreen> createState() => _DateFiltersScreenState();
}

class _DateFiltersScreenState extends State<DateFiltersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 40,
              width: 50,
            ),
            const Text(
              'Date filters',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DateOptionCard(
                onValueChanged: (List<dynamic> dates) {},
              ),
              const SizedBox(
                height: 16,
              ),
              const AgeSelectorCard(),
              const SizedBox(
                height: 16,
              ),
              SettingsTile(
                text: 'Select languages',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LanguagesScreen(
                      onLanguagesSelected: (List<dynamic> language) {

                      },
                    ),
                  ));
                },
                tittle: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Languages they know'),
                ),
              ),
              SettingsTile(
                text: 'Set advanced filters',
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AdvancedFiltersScreen(),
                  ));
                },
                tittle: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Advanced filters'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
