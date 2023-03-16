import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/presentation/blocs/auth/auth_bloc.dart';
import 'package:getmarried/widgets/button.dart';
import '../../../widgets/social_button.dart';
import '../number.dart';

class Onboard extends StatelessWidget {
   Onboard({Key? key}) : super(key: key);

  AuthBloc authBloc = AuthBloc(getIt.get());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.indigoAccent,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  )),
            ),
          ),
          Expanded(
              flex: 1,
              child: Center(
                child: Image.asset(
                  'assets/logo.png',
                ),
              )),
          const Expanded(
              flex: -1,
              child: Center(
                child: Text(
                  'Welcome! How do you want to get started?',
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              )),
          Expanded(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  const SizedBox(
                    height: 50,
                  ),
                  SocialButton(
                      icons: const Icon(
                        Icons.mail,
                        color: Colors.white,
                      ),
                      colour: Colors.redAccent,
                      title: 'Continue with Google',
                      textcolour: Colors.white,
                      ontap: () {
                        showCustomToast('Coming soon');
                        authBloc.add(GoogleSigninEvent());
                        /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Phone()));*/
                      }),
                  const Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SocialButton(
                      icons: const Icon(
                        Icons.apple_rounded,
                        color: Colors.white,
                      ),
                      colour: Colors.black,
                      title: 'Continue with Apple ID',
                      textcolour: Colors.white,
                      ontap: () {
                        showCustomToast('Coming soon');
                        /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Phone()));*/
                      }),
                  const Divider(
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SocialButton(
                      icons: const Icon(
                        Icons.facebook,
                        color: Colors.yellowAccent,
                      ),
                      colour: Colors.blue,
                      title: 'Continue with Facebook',
                      textcolour: Colors.white,
                      ontap: () {
                        showCustomToast('Coming soon');
                        /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Phone()));*/
                      }),
                  const Divider(
                    color: Colors.grey,
                  ),
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
                      }),
                  const SizedBox(
                    height: 16,
                  ),
                ]),
              ))
        ],
      ),
    );
  }
}
