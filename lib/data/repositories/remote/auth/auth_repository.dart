import 'package:firebase_auth/firebase_auth.dart';
import 'package:getmarried/data/models/api_response.dart';

abstract class AuthRepository {
  Future sendSms(
      {required String number,
      String? resendToken,
      required final Function(FirebaseAuthException exception)
          onVerificationFailed,
      required final Function(PhoneAuthCredential credential)
          onVerificationCompleted,
      required final Function(String verificationID, int? resendToken)
          onCodeSent,
      required final Function(String verificationID)
          onCodeAutoRetrievalTimeout});


  Future<ApiResponse> signinWithPhoneNumber(PhoneAuthCredential credential);
  Future<ApiResponse> signinUser(String uid);

  // Future void signinWithPhoneNumber

}
