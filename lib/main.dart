import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:getmarried/di/injector.dart' as injector;
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';
import 'package:getmarried/presentation/screens/home/home_screen.dart';
import 'package:getmarried/presentation/screens/registration/build_profile_onboard.dart';
import 'package:getmarried/presentation/screens/registration/privacy_screen.dart';
import 'package:getmarried/presentation/screens/registration/registration_screen.dart';
import 'package:getmarried/presentation/screens/registration/registration_steps/choose_mode.dart';
import 'package:getmarried/presentation/screens/splashScreen.dart';
import 'package:getmarried/store_config.dart';
import 'package:hive_flutter/adapters.dart';
import 'constant.dart';
import 'constants/storage_keys.dart';
import 'di/injector.dart';
import 'firebase_options.dart';
import 'helper/storage_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  injector.init();
  await Firebase.initializeApp();
  Future.delayed(const Duration(milliseconds: 300));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  CacheCubit cubit = getIt.get<CacheCubit>();
  cubit.getCachedUser();
  // Future.delayed(const Duration(milliseconds: 500));
  final firstScreen = await getFirstScreen();
  runApp(MyApp(
    firstScreen: firstScreen,
  ));

  if (Platform.isIOS || Platform.isMacOS) {
    StoreConfig(
      store: Store.appleStore,
      apiKey: appleApiKey,
    );
  } else if (Platform.isAndroid) {
    // Run the app passing --dart-define=AMAZON=true
    const useAmazon = bool.fromEnvironment("amazon");
    StoreConfig(
      store: useAmazon ? Store.amazonAppstore : Store.googlePlay,
      apiKey: useAmazon ? amazonApiKey : googleApiKey,
    );
  }

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
      home: Splashscreen(
        firstScreen: firstScreen,
      ),
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
      return const BuildProfileOnboard();
    } else {
      return const HomeScreen();
    }
  } else {
    return ChooseModeScreen(onComplete: () {});
  }
}
