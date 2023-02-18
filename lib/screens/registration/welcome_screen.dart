import 'package:flutter/material.dart';
import '../../constant.dart';
import '../../widgets/welcome_text_widget.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 200,
              ),

              const WelcomeTextWidget(),
              const SizedBox(
                height: 26,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
                },
                style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const StadiumBorder(),
                    primary: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 13)),
                child: const Text(
                  'I agree',
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
