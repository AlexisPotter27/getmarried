import 'package:flutter/material.dart';
import 'package:getmarried/widgets/button.dart';
import '../../../widgets/social_button.dart';
import '../number.dart';

class Onboard extends StatelessWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.indigoAccent,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
              flex: 3,
              child: Center(
                child: Image.asset(
                  'assets/logo.png',
                  width: 150,
                  height: 150,
                ),
              )),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                  const SizedBox(
                    height: 50,
                  ),
                      SocialButton(
                          icons: const Icon(Icons.mail,color: Colors.white,),
                          colour: Colors.redAccent,
                          title: 'Continue with google',
                          textcolour: Colors.white,
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Phone()));
                          }),
                      const SizedBox(
                        height: 16,
                      ),
                  SocialButton(
                      icons: const Icon(Icons.apple,color: Colors.white,),
                      colour: Colors.black,
                      title: 'Continue with apple',
                      textcolour: Colors.white,
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Phone()));
                      }),
                  const SizedBox(
                    height: 16,
                  ),
                  SocialButton(
                      icons: const Icon(Icons.facebook,color: Colors.white,),
                      colour: Colors.blueAccent,
                      title: 'Continue with Facebook',
                      textcolour: Colors.white,
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Phone()));
                      }),
                  const SizedBox(
                    height: 16,
                  ),
                  Button(
                      colour: Colors.white,
                      title: 'Use Mobile Number',
                      textcolour: Colors.black,
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Phone()));
                      })
                ]),
              ))
        ],
      ),
    );
  }
}
