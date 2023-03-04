import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:getmarried/di/injector.dart' as injector;
import 'package:getmarried/presentation/screens/home/home_screen.dart';
import 'package:getmarried/presentation/screens/registration/build_profile_screen.dart';
import 'package:getmarried/presentation/screens/registration/privacy_screen.dart';
import 'package:getmarried/presentation/screens/registration/registration_screen.dart';
import 'package:getmarried/presentation/screens/registration/registration_steps/choose_mode.dart';
import 'package:getmarried/presentation/screens/splashScreen.dart';
import 'package:hive_flutter/adapters.dart';

import 'constants/storage_keys.dart';
import 'helper/storage_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  injector.init();
  await Firebase.initializeApp();
  final firstScreen = await getFirstScreen();
  runApp( MyApp(firstScreen: firstScreen,));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.firstScreen}) : super(key: key);
  final Widget firstScreen;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Get Married',
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home:  Splashscreen( firstScreen:firstScreen,),
    );
  }
}

Future<Widget> getFirstScreen() async {
  bool stayLogin =
      await StorageHelper.getBoolean(StorageKeys.isUserLoggedIn, false);
  String? regStatus = await StorageHelper.getString(StorageKeys.regStatus);

  if (stayLogin) {
    if (regStatus == null) {
      return const PrivacyScreen();
    } else if (regStatus == '0') {
      return const RegistrationScreen();
    } else if (regStatus == '1') {
      return const BuildProfileScreen();
    } else {
      return const HomeScreen();
    }
  } else {
    return   ChooseModeScreen(onComplete: () {});
  }


}
