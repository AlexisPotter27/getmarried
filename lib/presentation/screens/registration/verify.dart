import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getmarried/constant.dart';
import 'package:getmarried/helper/toastMessage.dart';
import 'package:getmarried/presentation/screens/number.dart';
import 'package:getmarried/presentation/screens/registration/location.dart';

class Verify extends StatefulWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  State<Verify> createState() => _VerifyState();
}

TextEditingController countryCode = TextEditingController();
TextEditingController phoneController = TextEditingController();
String number = countryCode.text + phoneController.text;

class _VerifyState extends State<Verify> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      appBar: AppBar(
        centerTitle: true,
        title:  Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/ilogo.png', width: 50, height: 50,),
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
            const SizedBox(height: 20,),
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
                "Verify your number",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Enter the 6 digit verification code sent to your phone number',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),textAlign: TextAlign.start,
              ),
              Row(
                children: [
                   Text(num),
                  const SizedBox(width: 10,),
                  GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const Phone()));

                      },
                      child:  const Text('change',
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
                    height: 40,
                    width: 100,
                    decoration:  const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child:  Padding(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            Text(num,
                              overflow: TextOverflow.ellipsis,
                              style:const TextStyle(color: Colors.grey),),
                          ],
                        )
                    ),
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
                            hintText: 'XXXXXX',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none),
                        keyboardType: TextInputType.number,
                        controller: phoneController,

                      ),
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
                GestureDetector(
                  onTap: () {
                    if(phoneController.text.length == 6){
                      phoneController.clear();
                      countryCode.clear();
                      verifyCode();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Location()));
                    } else {
                      ToastMessage.showToast('Please the 6 digit code sent to your phone number.');
                    }
                  },
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,),
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
  void verifyCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationIDReceived,
        smsCode: phoneController.text);

    await auth.signInWithCredential(credential).then((value){
      ToastMessage.showToast('Verification successful');
      print('Verification successfully');
    });
  }
}