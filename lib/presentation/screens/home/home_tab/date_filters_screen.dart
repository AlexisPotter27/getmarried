import 'package:flutter/material.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/presentation/blocs/auth/auth_bloc.dart';
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';
import 'package:getmarried/presentation/screens/home/home_tab/advanced_filters_screen.dart';
import 'package:getmarried/presentation/screens/home/profile_tab/languages_screen.dart';
import 'package:getmarried/widgets/home/age_selector_card.dart';
import 'package:getmarried/widgets/home/date_option_card.dart';
import 'package:getmarried/widgets/date/settings_tile.dart';
import 'package:getmarried/widgets/home/location_range_selector.dart';

class DateFiltersScreen extends StatefulWidget {
  const DateFiltersScreen({Key? key}) : super(key: key);

  @override
  State<DateFiltersScreen> createState() => _DateFiltersScreenState();
}

class _DateFiltersScreenState extends State<DateFiltersScreen> {
  UserData user = getIt.get<CacheCubit>().user!;

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
              'assets/ilogo.png',
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DateOptionCard(
                  onValueChanged: (dates) {
                    setState(() {
                      user.dateFilters!.lookingFor = dates;
                      getIt.get<CacheCubit>().updateUser(user);
                      getIt.get<AuthBloc>().add(UpdateUserEvent(user));
                    });
                  },
                  value: user.dateFilters!.lookingFor?.toLowerCase() ?? 'men',
                ),
                const SizedBox(
                  height: 16,
                ),
                const AgeSelectorCard(),
                const SizedBox(
                  height: 16,
                ),
                const LocationRangeSelector(),
                const SizedBox(
                  height: 16,
                ),

                SettingsTile(
                  text: 'Select languages',
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LanguagesScreen(
                        selectedLanguages: user.dateFilters!.langiages!,
                        onLanguagesSelected: (List<String> language) {
                          user.dateFilters?.langiages = language;
                          getIt.get<CacheCubit>().updateUser(user);
                          getIt.get<AuthBloc>().add(UpdateUserEvent(user));
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
      ),
    );
  }
}
