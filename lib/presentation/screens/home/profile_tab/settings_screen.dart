import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/constants/storage_keys.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/helper/storage_helper.dart';
import 'package:getmarried/presentation/blocs/auth/auth_bloc.dart';
import 'package:getmarried/presentation/screens/registration/onboard.dart';
import 'package:getmarried/widgets/date/settings_tile.dart';
import 'package:getmarried/widgets/secondary_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AuthBloc authBloc = AuthBloc(getIt.get());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
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
              'Settings',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: primaryColour,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),
            ),
          ],
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SettingsTile(
                text: 'Choose mode',
                onPressed: () {},
                suffixIcon: Row(
                  children: [
                    const Text('Date'),
                    const SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 20,
                      color: Colors.grey.shade300,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SettingsTile(
                text: 'Date mode',
                onPressed: () {},
                suffixIcon: SizedBox(
                  height: 25,
                  child: Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                      value: false,
                      onChanged: (val) {},
                      activeColor: primaryColour,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Hide your profile in Data and just use BFF or Biz, If you do this, you\'ll lose your connections and chats in Date.',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SettingsTile(
                text: 'Snooze',
                onPressed: () {},
                suffixIcon: const SizedBox.shrink(),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                child: Text(
                  'Temporarily hide your profile from all modes, If you do this, you will lose all your connections and chats',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SettingsTile(
                text: 'Incognito mode',
                onPressed: () {},
                suffixIcon: SizedBox(
                  height: 25,
                  child: Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                      value: false,
                      onChanged: (val) {},
                      activeColor: primaryColour,
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Enable incognito mode so no one sees you unless you want them to. Only people you swipe right on will be able to view your profile',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SettingsTile(
                text: 'Current location',
                onPressed: () {},
                tittle: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  child: Text('Location'),
                ),
                suffixIcon: SizedBox(
                  height: 25,
                  child: Row(
                    children: const [
                      Text('Aba, NG'),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SettingsTile(
                text: 'Travel',
                onPressed: () {},
                suffixIconCOlor: Colors.white,
                textColor: Colors.white,
                prefixIcon: const Icon(
                  Icons.car_rental_outlined,
                  color: Colors.white,
                ),
                backgroundColor: Colors.blueAccent,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Change your location to connect with people in other locations',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SettingsTile(
                text: 'Notification settings',
                onPressed: () {},
              ),
              const SizedBox(
                height: 10,
              ),
              SettingsTile(
                text: 'Contact & FAQ',
                onPressed: () {},
              ),
              const SizedBox(
                height: 10,
              ),
              SettingsTile(
                text: 'Security & Privacy',
                onPressed: () {},
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                      shape: const StadiumBorder(),
                      backgroundColor: Colors.grey.shade300,
                      primary: Colors.black),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Log out',
                          style: TextStyle(),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              TransaparentButton(
                  child: const Text('Delete account'), onPressed: () {}),
              const SizedBox(
                height: 70,
              ),
            ],
      body: BlocListener<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          if (state is DeleteUserLoadingState) {
            showAnimatedProgressDialog(context, title: 'Deleting Account.');
          }
          if (state is DeleteUserSuccessState) {
            showCustomToast('Account deleted');
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Onboard(),
                ));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SettingsTile(
                  text: 'Choose mode',
                  onPressed: () {},
                  suffixIcon: Row(
                    children: [
                      const Text('Date'),
                      const SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 20,
                        color: Colors.grey.shade300,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SettingsTile(
                  text: 'Date mode',
                  onPressed: () {},
                  suffixIcon: SizedBox(
                    height: 25,
                    child: Transform.scale(
                      scale: 0.8,
                      child: CupertinoSwitch(
                        value: false,
                        onChanged: (val) {},
                        activeColor: primaryColour,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Hide your profile in Data and just use BFF or Biz, If you do this, you\'ll lose your connections and chats in Date.',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SettingsTile(
                  text: 'Snooze',
                  onPressed: () {},
                  suffixIcon: const SizedBox.shrink(),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                  child: Text(
                    'Temporarily hide your profile from all modes, If you do this, you will lose all your connections and chats',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SettingsTile(
                  text: 'Incognito mode',
                  onPressed: () {},
                  suffixIcon: SizedBox(
                    height: 25,
                    child: Transform.scale(
                      scale: 0.8,
                      child: CupertinoSwitch(
                        value: false,
                        onChanged: (val) {},
                        activeColor: primaryColour,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Enable incognito mode so no one sees you unless you want them to. Only people you swipe right on will be able to view your profile',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SettingsTile(
                  text: 'Current location',
                  onPressed: () {},
                  tittle: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    child: Text('Location'),
                  ),
                  suffixIcon: SizedBox(
                    height: 25,
                    child: Row(
                      children: const [
                        Text('Locating...'),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SettingsTile(
                  text: 'Travel',
                  onPressed: () {},
                  suffixIconCOlor: Colors.white,
                  textColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.car_rental_outlined,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.blueAccent,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Change your location to connect with people in other locations',
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SettingsTile(
                  text: 'Notification settings',
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 10,
                ),
                SettingsTile(
                  text: 'Contact & FAQ',
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 10,
                ),
                SettingsTile(
                  text: 'Security & Privacy',
                  onPressed: () {},
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    style: TextButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: Colors.grey.shade300,
                        foregroundColor: Colors.black),
                    onPressed: () {
                      StorageHelper.setBoolean(StorageKeys.isUserLoggedIn, false);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Onboard(),
                          ),
                          (route) => true);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Log out',
                            style: TextStyle(),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
                TransaparentButton(
                    child: const Text('Delete account'),
                    onPressed: () {
                      String id = FirebaseAuth.instance.currentUser!.uid;
                      authBloc.add(DeleteUserEvent(id));
                    }),
                const SizedBox(
                  height: 70,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
