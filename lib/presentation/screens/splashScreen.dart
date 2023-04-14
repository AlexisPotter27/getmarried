import 'dart:async';
import 'package:flutter/material.dart';
import 'package:getmarried/constants/constant.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key, required this.firstScreen}) : super(key: key);
  final Widget firstScreen;

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => widget.firstScreen));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:primaryColour,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/ilogo.png',
              height: 70,
              width: 70,
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
