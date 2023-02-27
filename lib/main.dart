import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:getmarried/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:getmarried/presentation/screens/home/home_screen.dart';
import 'package:getmarried/presentation/screens/registration/privacy_screen.dart';
import 'package:getmarried/presentation/screens/splashScreen.dart';
import '.env';

Future<void> main() async{ 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey = stripePublishableKey;
  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Get Married',
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: const Splashscreen(),
    );
  }
}
