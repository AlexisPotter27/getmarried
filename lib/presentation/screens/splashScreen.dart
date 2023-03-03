import 'dart:async';
import 'package:flutter/material.dart';
import 'package:getmarried/presentation/screens/registration/registration_steps/choose_mode.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ChooseModeScreen(onComplete: () {})));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: Center(
                child: Image.asset(
                  'assets/logo.png',
                ),
              )),
        ],
      ),
    );
  }
}
