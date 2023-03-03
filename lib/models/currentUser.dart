
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CurrentUser extends ChangeNotifier{
  //String _uid;
  //int _phoneNumber;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signUpUser(int phoneNumber) async {
    bool retVal = false;

    try{
   //   UserCredential userCredential = await _auth.signInWithCredential(_phoneNumber);
    }catch(e){
      print(e);
    }

    return retVal;
  }
}