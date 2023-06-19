import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getmarried/presentation/screens/home/home_screen.dart';
import 'package:getmarried/presentation/screens/registration/wrapper.dart';
import 'package:getmarried/widgets/reigistration/welcome_text_widget.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(
          'assets/ilogo.png',
          width: 50,
          height: 50,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigoAccent,
      ),
      backgroundColor: Colors.indigoAccent,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /* Row(
                children: [
                  Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/ilogo.png',
                            height: 40,
                            width: 50,
                          ),
                        ],
                      )
                  )
                ],
              ),
              const SizedBox(
                height: 200,
              ),*/
              const WelcomeTextWidget(),
              const SizedBox(
                height: 26,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Wrapper(),
                      ));
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
