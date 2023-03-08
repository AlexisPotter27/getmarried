import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/data/models/chip_choice_mode.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';
import 'package:getmarried/widgets/profile_tab/basics_section.dart';
import 'package:getmarried/widgets/profile_tab/connect_account_widget.dart';
import 'package:getmarried/widgets/profile_tab/chips_box.dart';
import 'package:getmarried/widgets/profile_tab/more_about_section.dart';
import 'package:getmarried/widgets/profile_tab/photos_widget.dart';
import 'package:getmarried/widgets/profile_tab/profile_list_tile.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  UserData cachedUser = getIt.get<CacheCubit>().user!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              'Get married',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: primaryColour,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
          ],
        ),
        foregroundColor: Colors.black,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Profile Strength',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(width: 0.5))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '8% complete',
                        style: TextStyle(fontSize: 16),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey.shade300,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'My photos',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, height: 2),
              ),
              const Text(
                'Pick some that show the true you',
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(
                height: 16,
              ),
              PhotosWidget(
                photos: cachedUser.photos ?? [],
              ),
              const SizedBox(
                height: 16,
              ),
              ProfileListTile(
                preffix: const Icon(
                  Icons.image,
                  size: 20,
                ),
                tittle: 'Best Photo',
                value: 'On',
                onTap: () {},
              ),
              const SizedBox(
                height: 16,
              ),
              ProfileListTile(
                preffix: const Icon(
                  Icons.shield_moon,
                  size: 20,
                  color: Colors.blueAccent,
                ),
                tittle: 'Verify my profile',
                value: 'Verified',
                onTap: () {},
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'My interests',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Get specific about the things you love',
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ChipsBox(
                    items: cachedUser.interests!
                        .map((e) => ChipChoiceModel(
                            label: e.toString(), icon: Icons.sports_score))
                        .toList(),
                  )),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Profile prompts',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Make your personality stand out from the crowd',
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(
                height: 16,
              ),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(width: 0.5))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Add new',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey.shade300,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'My bio',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Write a fun and punchy intro',
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                maxLines: 3,
                decoration: inputDecoration(context).copyWith(
                    filled: false,
                    hintText: 'A little bit about you',
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 13),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(16)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(16)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300))),
              ),
              const SizedBox(
                height: 16,
              ),
              const BasicsSection(),
              const SizedBox(
                height: 16,
              ),
              const MoreAboutSection(),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Language i know',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ChipsBox(
                    items: myLanguage,
                  )),
              const SizedBox(
                height: 16,
              ),
              const ConnectAccountWidget(),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
