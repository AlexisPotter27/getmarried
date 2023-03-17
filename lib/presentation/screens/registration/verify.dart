import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/constants/storage_keys.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/helper/storage_helper.dart';
import 'package:getmarried/helper/toastMessage.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/presentation/blocs/auth/auth_bloc.dart';
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';
import 'package:getmarried/presentation/screens/home/home_screen.dart';
import 'package:getmarried/presentation/screens/number.dart';
import 'package:getmarried/presentation/screens/registration/build_profile_screen.dart';
import 'package:getmarried/presentation/screens/registration/location.dart';
import 'package:getmarried/presentation/screens/registration/registration_screen.dart';
import 'package:getmarried/widgets/reigistration/next_button.dart';

class Verify extends StatefulWidget {
  const Verify({Key? key, required this.verificationId}) : super(key: key);
  final String verificationId;

  @override
  State<Verify> createState() => _VerifyState();
}

TextEditingController countryCode = TextEditingController();
TextEditingController phoneController = TextEditingController();
String number = countryCode.text + phoneController.text;
AuthBloc authBloc = getIt.get<AuthBloc>();

class _VerifyState extends State<Verify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      appBar: AppBar(
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/ilogo.png',
            width: 50,
            height: 50,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.indigoAccent,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          if (state is PhoneAuthLoadingState) {
            showAnimatedProgressDialog(context);
          }

          if (state is PhoneAuthSuccessState) {
            getIt.get<CacheCubit>().updateUser(state.userData);
            getIt.get<CacheCubit>().getCachedUser();

            updateCache();

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => getNextScreen(state.userData)));
          }
          if (state is PhoneAuthFailureState) {
            Navigator.pop(context);
            showCustomToast(state.error);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text(
                    "Verify your number",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Enter the 6 digit verification code sent to your phone number',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                    textAlign: TextAlign.start,
                  ),
                  Row(
                    children: [
                      Text(num),
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
                    height: 20,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 100,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  num,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            )),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: 200,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          autofocus: true,
                          cursorColor: primaryColour,
                          onFieldSubmitted: (val){
                            verifyCode(
                                verificationId: widget.verificationId,
                                smsCode: phoneController.text);
                          },
                          onChanged: (val) {
                            setState(() {});
                          },
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              hintText: 'XXXXXX',
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none),
                          keyboardType: TextInputType.number,
                          controller: phoneController,
                        ),
                      )
                    ],
                  ),
                ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: const Text(
                        'Didn\'t get a call?',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    NextButton(onPressed: () {
                      if (phoneController.text.length == 6) {
                        verifyCode(
                            verificationId: widget.verificationId,
                            smsCode: phoneController.text);
                        phoneController.clear();

                      } else {
                        ToastMessage.showToast(
                            'Please enter a invalid phone number.');
                      }
                    })
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void verifyCode(
      {required String verificationId, required String smsCode}) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: phoneController.text);

    authBloc.add(PhoneNumberSigninEvent(credential));

    // await auth.signInWithCredential(credential).then((value){
    //   ToastMessage.showToast('Verification successful');
    //   print('Verification successfully');
    // });
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
      return const HomeScreen();
    }
  }

  void updateCache() {
    StorageHelper.setBoolean(StorageKeys.isUserLoggedIn, true);

  }
}
