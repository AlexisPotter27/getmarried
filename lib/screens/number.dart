import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constant.dart';
import 'call.dart';

class Phone extends StatefulWidget {
  const Phone({Key? key}) : super(key: key);

  @override
  State<Phone> createState() => _PhoneState();
}

TextEditingController countryCode = TextEditingController();
TextEditingController phoneController = TextEditingController();
String number = countryCode.text + phoneController.text;
String num = number;

class _PhoneState extends State<Phone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigoAccent,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 10,
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
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text(
                "What's your number?",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'We protect our community by\nmaking sure everyone on GetMarriedApp is\nreal',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: Colors.white),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    height: 40,
                    width: 120,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 10),
                          child: IntlPhoneField(
                            decoration: const InputDecoration(
                              border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                            ),
                            showCountryFlag: false,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                            controller: countryCode,
                            dropdownIconPosition: IconPosition.trailing,
                            disableLengthCheck: true,
                            initialCountryCode: 'US',
                            onChanged: (phone) {
                              print(phone.completeNumber);
                            },
                          ),
                        )),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 40,
                    width: 200,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        autofocus: true,
                        cursorColor: primaryColour,
                        onChanged: (val) {
                          setState(() {});
                        },
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(10),
                            hintText: 'Phone number',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none),
                        keyboardType: TextInputType.number,
                        controller: phoneController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your phone number';
                          } else if (value.length < 14) {
                            return 'phone number should be more than 14 characters';
                          }
                          return null;
                        },
                      ),
                    ),
                  )
                ],
              ),
            ]),
            Row(
              children: [
           Expanded(
             child: Row(children: const [
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
             ],),
           ), 
                GestureDetector(
                  onTap: () {
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
                                    width: MediaQuery.of(context).size.width,
                                    //padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
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
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            'We need to make sure that',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.center,
                                          ),
                                          Text(
                                            '$number is your number',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.center,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text(
                                                    'CANCEL',
                                                    style: TextStyle(
                                                        color: primaryColour),
                                                  )),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    //Phone Verification

                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => const Call()));

                                                  },
                                                  child: const Text(
                                                    'OK',
                                                    style: TextStyle(
                                                        color: primaryColour),
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
                  },
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.black87,
                    child: Center(
                      child: Icon(Icons.arrow_forward_ios_outlined),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
  void verifyNumber(){

  }
}
