import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getmarried/constants/constant.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/helper/toastMessage.dart';
import 'package:getmarried/presentation/blocs/auth/auth_bloc.dart';
import 'package:getmarried/presentation/screens/registration/call.dart';
import 'package:getmarried/widgets/reigistration/next_button.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Phone extends StatefulWidget {
  const Phone({Key? key}) : super(key: key);

  @override
  State<Phone> createState() => _PhoneState();
}

TextEditingController countryCode = TextEditingController();
TextEditingController phoneController = TextEditingController();
String number = countryCode.text + phoneController.text;
String num = number;
String verificationIDReceived = "";

class _PhoneState extends State<Phone> {
  AuthBloc authBloc = getIt.get<AuthBloc>();

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

            /* Center(
              heightFactor: 1,
              child: Image.asset(
                'assets/logo.png',
                height: 35,
                width: 60,
              ),
            ),*/
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          if (state is SendSmsLoadingState) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const Call(),
            ));
            // showAnimatedProgressDialog(context);
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
                    "What's your number?",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'We protect our community by making sure everyone on GetMarriedApp is real',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            child: IntlPhoneField(
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                hintStyle: TextStyle(),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                              //  showCountryFlag: true,

                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.w500),
                              controller: countryCode,
                              dropdownIconPosition: IconPosition.trailing,
                              disableLengthCheck: true,
                              //  initialCountryCode: 'US',

                              //  onCountryChanged: (),
                              onChanged: (phone) {
                                print('FullNumber: ${phone.completeNumber}');
                                number = phone.completeNumber;
                                print(number);
                              },
                              onCountryChanged: (country) {
                                // countryCode.text = '+${country.dialCode}';
                                // print('Code:${countryCode.text}');
                              },
                            ),
                          )),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      // Container(
                      //
                      //   width: 200,
                      //   decoration: const BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.all(Radius.circular(5))),
                      //   child: TextFormField(
                      //     textInputAction: TextInputAction.done,
                      //     autofocus: true,
                      //     cursorColor: primaryColour,
                      //     onChanged: (val) {
                      //       setState(() {});
                      //     },
                      //     decoration: const InputDecoration(
                      //         contentPadding: EdgeInsets.all(10),
                      //         hintText: 'Phone number',
                      //         hintStyle: TextStyle(color: Colors.grey),
                      //         border: InputBorder.none),
                      //     keyboardType: TextInputType.number,
                      //     controller: phoneController,
                      //     validator: (value) {
                      //       if (value!.isEmpty) {
                      //         return 'please enter your phone number';
                      //       } else if (value.length < 14) {
                      //         return 'phone number should be more than 14 characters';
                      //       }
                      //       return null;
                      //     },
                      //   ),
                      // )
                    ],
                  ),
                ]),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: const [
                          Icon(
                            FontAwesomeIcons.lock,
                            size: 30,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              'We never share this with anyone and it won\'t be on your profile',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                    NextButton(
                      onPressed: () {
                        if (countryCode.text.length == 10 ||
                            countryCode.text.length == 11) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Dialog(
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          //padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.2,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'We need to verify your number',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                  'We need to make sure that',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  textAlign: TextAlign.center,
                                                ),
                                                Text(
                                                  '$number is your number',
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  textAlign: TextAlign.center,
                                                ),
                                                const SizedBox(
                                                  height: 16,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () {
                                                          phoneController
                                                              .clear();
                                                          countryCode.clear();
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          'CANCEL',
                                                          style: TextStyle(
                                                              color:
                                                                  primaryColour),
                                                        )),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    GestureDetector(
                                                        onTap: () {
                                                          phoneController.clear();
                                                          countryCode.clear();
                                                          Navigator.pop(
                                                              context);
                                                          authBloc.add(
                                                              SendOtpEvent(
                                                                  number:
                                                                      number));

                                                          //Phone Verification
                                                          // verifyNumber();
                                                          // Navigator.push(
                                                          //     context,
                                                          //     MaterialPageRoute(
                                                          //         builder: (context) =>
                                                          //             const Call()));
                                                        },
                                                        child: const Text(
                                                          'OK',
                                                          style: TextStyle(
                                                              color:
                                                                  primaryColour),
                                                        )),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        } else {
                          ToastMessage.showToast(
                              'Please enter a invalid phone number.');
                        }
                      },
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }

// void verifyNumber() {
//   print('This is with code: $number');
//   print('Only Number: $phoneController');
//   print('Country Code: $countryCode');
//
//   auth.verifyPhoneNumber(
//       phoneNumber: number,
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         await auth.signInWithCredential(credential).then((value) {
//           ToastMessage.showToast('Verification successful.');
//           phoneController.clear();
//           countryCode.clear();
//           log("You are logged in successfully");
//         });
//
//         log('verified');
//       },
//       verificationFailed: (FirebaseAuthException exception) {
//         ToastMessage.showToast('Verification failed.');
//         log(exception.message!);
//       },
//       codeSent: (String verificationID, int? resendToken) {
//         verificationIDReceived = verificationID;
//         setState(() {
//           ToastMessage.showToast('Code sent.');
//         });
//       },
//       codeAutoRetrievalTimeout: (String verificationID) {});
// }
}
