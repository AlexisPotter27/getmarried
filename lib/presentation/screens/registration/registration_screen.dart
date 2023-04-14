import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/constants/storage_keys.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/helper/storage_helper.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/presentation/blocs/auth/auth_bloc.dart';
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';
import 'package:getmarried/presentation/screens/registration/registration_steps/add_photos_screen.dart';
import 'package:getmarried/presentation/screens/registration/registration_steps/birthday_screen.dart';
import 'package:getmarried/presentation/screens/registration/registration_steps/choose_date_screen.dart';
import 'package:getmarried/presentation/screens/registration/registration_steps/email_screen.dart';
import 'package:getmarried/presentation/screens/registration/registration_steps/first_name_screen.dart';
import 'package:getmarried/presentation/screens/registration/registration_steps/gender_screen.dart';
import 'build_profile_onboard.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _pageController = PageController();
  double progress = 0.11;
  UserData? cachedUser = getIt.get<CacheCubit>().user;
  AuthBloc authBloc = AuthBloc(getIt.get());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.indigoAccent,
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          if (state is UpdateUserLoadingState) {
            showAnimatedProgressDialog(context);
          }
          if (state is UpdateUserSuccessState) {
            updateCache();
            Navigator.pop(context);
            getIt.get<CacheCubit>().updateUser(state.userData);

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const BuildProfileOnboard(),
                ));
          }
          if (state is UpdateUserFailureState) {
            Navigator.pop(context);
            showCustomToast(state.error);
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  LinearProgressIndicator(
                    minHeight: 5,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.black),
                    backgroundColor: Colors.white.withOpacity(0.3),
                    value: progress,
                  ),
                  Expanded(
                      child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // ChooseModeScreen(
                      //   onComplete: () {
                      //     switchPage(1);
                      //   },
                      // ),
                      FirstNameScreen(onComplete: (name) {
                        setState(() {
                          cachedUser?.firstname = name;
                        });
                        switchPage(1);
                      }),
                      AddPhotosScreen(
                        onComplete: (images) {
                          setState(() {
                            cachedUser!.photos = images;
                          });
                          switchPage(2);
                        },
                        onPrev: () {
                          prevPage(0);
                        },
                      ),
                      BirthdayScreen(onPrev: () {
                        prevPage(1);
                      }, onComplete: (dob) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                              actionsPadding: const EdgeInsets.all(16),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'You are ${_getAge(dob)}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                      'Make sure this is your correct age as you cant change this later'),
                                ],
                              ),
                              actions: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'CANCEL',
                                    style: TextStyle(color: primaryColour),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    cachedUser?.dateOfBirth = dob.toString();
                                    cachedUser?.age = _getAge(dob);
                                    Navigator.pop(context);
                                    switchPage(3);
                                  },
                                  child: const Text(
                                    'CONFIRM',
                                    style: TextStyle(color: primaryColour),
                                  ),
                                ),
                              ]),
                        );
                        // switchPage(3);
                      }),
                      GenderScreen(
                        onPrev: () {
                          prevPage(2);
                        },
                        onComplete: (gender) {
                          cachedUser?.gender = gender;
                          switchPage(4);
                        },
                      ),
                      /*ShowGenderScreen(
                    onComplete: () {
                      switchPage(5);
                    },
                  ),*/
                      ChooseDateScreen(
                        onPrev: () {
                          prevPage(3);
                        },
                        onComplete: (date) {
                          cachedUser?.dateMatch = date;
                          switchPage(5);
                        },
                      ),
                      /*ChooseReletionShipType(
                    onComplete: () {
                      switchPage(8);
                    },
                  ),*/
                      EmailScreen(
                        onPrev: () {
                          prevPage(4);
                        },
                        onComplete: (email) {
                          cachedUser?.email = email;

                          authBloc.add(UpdateUserEvent(cachedUser!));
                          // Navigator.of(context).pushReplacement(MaterialPageRoute(
                          //   builder: (context) => const BuildProfileOnboard(),
                          // ));
                        },
                      )
                      // InterestScreen(),
                      // HeightScreen(),
                      // BirthdayScreen(),
                      // AddPhotosScreen(),
                    ],
                  )),
                  SizedBox(height:  kIsWeb? 35:0,)


                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void switchPage(int to) {
    setState(() {
      _pageController.jumpToPage(to);
      progress += 0.2;
    });
  }

  void prevPage(int to) {
    setState(() {
      _pageController.jumpToPage(to);
      progress -= 0.2;
    });
  }

  void updateCache() {
    StorageHelper.setString(StorageKeys.regStatus, '1');
  }

  _getAge(DateTime dob) {
    return (DateTime.now().year - dob.year).toString();
  }
}
