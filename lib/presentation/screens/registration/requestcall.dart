import 'package:flutter/material.dart';
import 'package:getmarried/constant.dart';
import 'package:getmarried/presentation/screens/registration/call.dart';
import 'package:getmarried/widgets/button.dart';

import '../number.dart';

class RequestCall extends StatelessWidget {
  const RequestCall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColour,
      body: Column(
        children: [
          Expanded(flex: 4, child: Container()),
          Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "We're going to\ncall you ",
                      style:
                      TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Enter the last 6 numbers of the\nphone number we call you on',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Row(

                      children: [
                        const Text('+2975XXX XXX'),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Phone()));
                            },
                            child: const Text(
                              'change',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Button(
                      title: 'Call me',
                      colour: Colors.white,
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Call()));
                      },
                      textcolour: Colors.black87,
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}