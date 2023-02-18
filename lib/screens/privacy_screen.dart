import 'package:flutter/material.dart';
import 'package:getmarried/screens/registration/registration_screen.dart';
import '../widgets/primary_button.dart';
import '../widgets/privacy_widget.dart';
import '../widgets/secondary_widget.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const PrivacyWidget(),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'We care about your privacy',
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      RichText(
                          text: const TextSpan(
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  height: 1.3),
                              children: [
                            TextSpan(text: 'Along with our '),
                            TextSpan(
                                text: 'partners ',
                                style: TextStyle(
                                    decoration: TextDecoration.underline)),
                            TextSpan(
                                text:
                                    'we store and process info from our device to provide features in the app and improve marketing campaigns.'),
                          ])),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: const TextSpan(
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                height: 1.3),
                            children: [
                              TextSpan(
                                  text:
                                      'You can always make changes or opt out in your privacy settings. Find out more find out more in our '),
                              TextSpan(
                                  text: 'privacy policy',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline))
                            ]),
                      ),
                    ],
                  ),
                ),
              ),
              PrimaryButton(

                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const RegistrationScreen(),
                    ));
                  },
                  child: const Text(
                    'Accept',
                      style: TextStyle(color: Colors.black,),
                  )),
              const SizedBox(
                height: 10,
              ),
              TransaparentButton(
                  onPressed: () {}, child: const Text('Change or reject', style: TextStyle(color: Colors.white,),)),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
