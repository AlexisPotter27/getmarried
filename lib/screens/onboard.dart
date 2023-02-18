import 'package:flutter/material.dart';
import '../constant.dart';
import '../widgets/button.dart';
import '../widgets/facebook.dart';
import 'number.dart';

class Onboard extends StatelessWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      body: Column(
        children: [
          Expanded(
              flex: 3,
              child: Container(

                // decoration: BoxDecoration(
                //   image: DecorationImage(
                //     image: const AssetImage('assets/logo.png'),
                //     fit: BoxFit.fill,
                //     colorFilter: ColorFilter.mode(
                //         Colors.black.withOpacity(0.1), BlendMode.dstATop),
                //   ),
                // ),
                child: Center(
                  child: Image.asset(
                    'assets/logo.png',
                  ),
                ),
              )),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: Column(children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Facebook(
                        icons: Icons.facebook,
                        colour: Colors.yellow,
                        title: 'Continue with Facebook',
                        textcolour: Colors.black,
                        ontap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Phone() ));
                        }),
                    const SizedBox(
                      height: 30,
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
                ),
              ))
        ],
      ),
    );
  }
}