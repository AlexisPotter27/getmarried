import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getmarried/constant.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/constants/storage_keys.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/helper/app_utils.dart';
import 'package:getmarried/helper/storage_helper.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/presentation/blocs/auth/auth_bloc.dart';
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';
import 'package:getmarried/presentation/screens/registration/registration_screen.dart';
import 'package:getmarried/widgets/primary_button.dart';
import 'package:getmarried/widgets/privacy_widget.dart';
import 'package:getmarried/widgets/secondary_widget.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  AuthBloc authBloc = AuthBloc(getIt.get());
  UserData? userData = getIt.get<CacheCubit>().user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColour,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // title: Image.asset(
        //   'assets/ilogo.png',
        //   width: 50,
        //   height: 50,
        // ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: primaryColour,
      ),
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          if (state is UpdateUserFailureState) {
            Navigator.pop(context);
            showCustomToast(state.error);
          }
          if (state is UpdateUserLoadingState) {
            showAnimatedProgressDialog(context);
          }

          if (state is UpdateUserSuccessState) {
            updateCache(state.userData);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegistrationScreen(),
                ));
          }
        },
        builder: (context, state) {
          return SafeArea(
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
                            'Our Terms and Privacy Information',
                            style: TextStyle(
                                fontSize: 30,
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
                                      fontSize: 14,
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
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    height: 1.3),
                                children: [
                                  TextSpan(
                                      text:
                                          'You can always make changes or opt out in your privacy settings. Find out more '),
                                  TextSpan(
                                      text: 'privacy',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline))
                                ]),
                          ),
                          SizedBox(height: 16,),
                          Text(
                            terms,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                height: 1.3),
                          )
                        ],
                      ),
                    ),
                  ),
                  PrimaryButton(
                      bgColor: Colors.white,
                      onPressed: () {
                        // if (userData != null) {
                        //   authBloc.add(UpdateUserEvent(userData!
                        //       .copyWith(acceptedPrivacy: true, regStatus: 0)));
                        // } else {
                        //   showCustomToast('An error occurred, please retry ');
                        //   getIt.get<CacheCubit>().getCachedUser();
                        // }
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RegistrationScreen(),
                        ));
                      },
                      padding: EdgeInsets.all(16),
                      child: const Text(
                        'Accept',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  TransaparentButton(
                      onPressed: () {
                        showCustomToast('To continue you have to the user terms above.');
                      },
                      child: const Text(
                        'Change or reject',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void updateCache(UserData userData) {
    getIt.get<CacheCubit>().updateUser(userData);
    StorageHelper.setString(StorageKeys.regStatus, '0');
  }
}
