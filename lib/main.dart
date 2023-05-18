import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:getmarried/admin/presentation/screens/admin_home.dart';
import 'package:getmarried/admin/presentation/screens/admin_login_screen.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/di/injector.dart' as injector;
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';
import 'package:getmarried/presentation/screens/home/home_screen.dart';
import 'package:getmarried/presentation/screens/registration/build_profile_onboard.dart';
import 'package:getmarried/presentation/screens/registration/onboarding_screen.dart';
import 'package:getmarried/presentation/screens/registration/privacy_screen.dart';
import 'package:getmarried/presentation/screens/registration/registration_steps/choose_mode.dart';
import 'package:getmarried/presentation/screens/registration/wrapper.dart';
import 'package:getmarried/presentation/screens/splashScreen.dart';
import 'package:getmarried/services/push_notification_service.dart';
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
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  PushNotificationService.initialize();
  injector.init();
  // await Firebase.initializeApp(
  //
  // );
  // Future.delayed(const Duration(milliseconds: 300));

  CacheCubit cubit = getIt.get<CacheCubit>();
  cubit.getCachedUser();
  // Future.delayed(const Duration(milliseconds: 500));
  final firstScreen = await getFirstScreen();
  final adminScreen = await getAdminFirstScreen();
  /*if (Platform.isIOS || Platform.isMacOS) {
    StoreConfig(
      store: Store.appleStore,
      apiKey: appleApiKey,
    );
  } else if (Platform.isAndroid) {
    // Run the app passing --dart-define=AMAZON=true
    //const useAmazon = bool.fromEnvironment("amazon");
    StoreConfig(
      store:  Store.googlePlay,
      apiKey: googleApiKey,
    );
  }*/
  if (defaultTargetPlatform == TargetPlatform.android) {
    StoreConfig(
      store: Store.googlePlay,
      apiKey: googleApiKey,
    );
  } else {
    StoreConfig(
      store: Store.appleStore,
      apiKey: appleApiKey,
    );
  }
  runApp(MyApp(
    firstScreen: firstScreen,
    adminFirstScreen: adminScreen,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp(
      {Key? key, required this.firstScreen, required this.adminFirstScreen})
      : super(key: key);
  final Widget firstScreen;
  final Widget adminFirstScreen;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Get Married',
      routes: {'/admin': (context) => adminFirstScreen},
      theme: ThemeData(
        fontFamily: 'Poppins',
        // primaryColor: primaryColour
      ),
      home: kIsWeb
          ? firstScreen
          : Splashscreen(
              firstScreen: firstScreen,
            ),
    );
  }
}

Future<Widget> getFirstScreen() async {
  bool stayLogin =
      await StorageHelper.getBoolean(StorageKeys.isUserLoggedIn, false);
  bool isFirstTime =
      await StorageHelper.getBoolean(StorageKeys.isFirstTime, true);
  String? regStatus = await StorageHelper.getString(StorageKeys.regStatus);

  if (!isFirstTime) {
    if (stayLogin) {
      if (regStatus == null) {
        return const PrivacyScreen();
      } else if (regStatus == '1') {
        return const BuildProfileOnboard();
      } else {
        return const Wrapper();
      }
    } else {
      return ChooseModeScreen(onComplete: () {});
    }
  } else {
    return OnboardingScreen();
  }
}

Future<Widget> getAdminFirstScreen() async {
  bool stayLogin =
      await StorageHelper.getBoolean(StorageKeys.adminLoggedIn, false);

  if (stayLogin) {
    return AdminHome();
  } else {
    return AdminLoginScreen();
  }
}
