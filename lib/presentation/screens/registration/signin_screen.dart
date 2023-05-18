import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/constants/storage_keys.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/helper/storage_helper.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/presentation/blocs/auth/auth_bloc.dart';
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';
import 'package:getmarried/presentation/screens/home/home_screen.dart';
import 'package:getmarried/presentation/screens/registration/location.dart';
import 'package:getmarried/presentation/screens/registration/registration_screen.dart';
import 'package:getmarried/presentation/screens/registration/wrapper.dart';
import 'package:getmarried/widgets/button.dart';
import '../../../widgets/social_button.dart';
import '../number.dart';
import 'build_profile_screen.dart';

class SigninScreen extends StatelessWidget {
  SigninScreen({Key? key}) : super(key: key);

  AuthBloc authBloc = AuthBloc(getIt.get());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.indigoAccent,
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          if (state is GoogleSignInLoadingState) {
            showAnimatedProgressDialog(context);
          }
          if (state is GoogleSignInSuccessState) {
            getIt.get<CacheCubit>().updateUser(state.user);
            getIt.get<CacheCubit>().getCachedUser();
            updateCache();

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => getNextScreen(state.user)));
          }
          if (state is GoogleSignInFailureState) {
            Navigator.pop(context);
            showCustomToast(state.error);
          }
          if (state is FacebookSignInLoadingState) {
            showAnimatedProgressDialog(context);
          }
          if (state is FacebookSignInSuccessState) {
            getIt.get<CacheCubit>().updateUser(state.user);
            getIt.get<CacheCubit>().getCachedUser();

            updateCache();

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => getNextScreen(state.user)));
          }
          if (state is FacebookSignInFailedState) {
            Navigator.pop(context);
            showCustomToast(state.error);
          }
          if (state is AppleSignInLoadingState) {
            showAnimatedProgressDialog(context);
          }
          if (state is AppleSignInSuccessState) {
            getIt.get<CacheCubit>().updateUser(state.user);
            getIt.get<CacheCubit>().getCachedUser();

            updateCache();

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => getNextScreen(state.user)));
          }
          if (state is AppleSignInFailureState) {
            Navigator.pop(context);
            showCustomToast(state.error);
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: AssetImage('assets/jpeg/married.jpg'))),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                        Colors.black.withOpacity(0.2),
                        Colors.black.withOpacity(0.5),
                        Colors.black.withOpacity(0.5),
                        Colors.black.withOpacity(1),
                        Colors.black.withOpacity(1)
                      ])),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  const Expanded(
                      flex: -1,
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  // Align(
                  //   alignment: Alignment.topLeft,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: IconButton(
                  //         onPressed: () {
                  //           Navigator.pop(context);
                  //         },
                  //         icon: Icon(
                  //           Icons.arrow_back_ios,
                  //           color: Colors.black,
                  //         )),
                  //   ),
                  // ),
                  // Expanded(
                  //     flex: 1,
                  //     child: Center(
                  //       child: Image.asset(
                  //         'assets/connected1.png',
                  //
                  //       ),
                  //     )),
                  Spacer(),
                  Expanded(
                      flex: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 26.0, vertical: 16.0),
                        child: Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                kIsWeb
                                    ? SizedBox.shrink()
                                    : Column(
                                        children: [
                                          SocialButton(
                                              icons: const Icon(
                                                FontAwesomeIcons.google,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                              colour: Colors.redAccent,
                                              title: 'Continue with Google',
                                              textcolour: Colors.white,
                                              ontap: () {
                                                authBloc
                                                    .add(GoogleSigninEvent());
                                                /*Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Phone()));*/
                                              }),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          SocialButton(
                                              icons: const Icon(
                                                Icons.facebook,
                                                color: Colors.white,
                                              ),
                                              colour: Colors.blue,
                                              title: 'Continue with Facebook',
                                              textcolour: Colors.white,
                                              ontap: () async {
                                                authBloc
                                                    .add(FacebookSigninEvent());
                                                /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Phone()));*/
                                              }),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          SocialButton(
                                              icons: const Icon(
                                                Icons.apple_rounded,
                                                color: Colors.white,
                                              ),
                                              colour: Colors.black38,
                                              title: 'Continue with Apple ID',
                                              textcolour: Colors.white,
                                              ontap: () async {
                                                authBloc
                                                    .add(AppleSigninEvent());

                                                // ignore: avoid_print

                                                // This is the endpoint that will convert an authorization code obtained
                                                // via Sign in with Apple into a session in your system

                                                // final session = await http.Client().post(
                                                //   signInWithAppleEndpoint,
                                                // );

                                                // showCustomToast('Coming soon');
                                                /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Phone()));*/
                                              }),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                        ],
                                      ),
                                Button(
                                    colour: Colors.white,
                                    title: 'Use Mobile Number',
                                    textcolour: Colors.black,
                                    ontap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Phone()));
                                    }),
                                const SizedBox(
                                  height: 16,
                                ),
                              ]),
                        ),
                      ))
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget getNextScreen(UserData userData) {
    if (userData.regStatus == null) {
      return const Location();
    } else if (userData.regStatus == 0) {
      return const RegistrationScreen();
    } else if (userData.regStatus == 1) {
      return const BuildProfileScreen();
    } else {
      StorageHelper.setString(StorageKeys.regStatus, '2');
      return const Wrapper();
    }
  }

  void updateCache() {
    StorageHelper.setBoolean(StorageKeys.isUserLoggedIn, true);
  }
}
