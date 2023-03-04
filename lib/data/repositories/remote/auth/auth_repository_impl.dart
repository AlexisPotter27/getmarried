import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:getmarried/constants/firebase_keys.dart';
import 'package:getmarried/data/models/api_response.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/presentation/screens/number.dart';

import 'auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
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
          onCodeAutoRetrievalTimeout}) async {
    log('This is with code: $number');
    log('Only Number: $phoneController');
    log('Country Code: $countryCode');

    auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential) async {
          onVerificationCompleted(credential);

          // await auth.signInWithCredential(credential).then((value) {
          //   // ToastMessage.showToast('Verification successful.',);
          //   phoneController.clear();
          //   countryCode.clear();
          //   log("You are logged in successfully");
          // });

          log('verified');
        },
        verificationFailed: (FirebaseAuthException exception) {
          // ToastMessage.showToast('Verification failed.');
          onVerificationFailed(exception);
          log(exception.message!);
        },
        codeSent: (String verificationID, int? resendToken) {
          verificationIDReceived = verificationID;
          onCodeSent(verificationID, resendToken);
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          onCodeAutoRetrievalTimeout(verificationID);
        });
  }

  @override
  Future<ApiResponse> signinWithPhoneNumber(credential) async {
    try {
      UserCredential user = await auth.signInWithCredential(credential);

      if (user.user != null) {
        return await signinUser(user.user!.uid);
      } else {
        return ApiResponse(data: null, error: 'Signing failed please retry');
      }
    } on FirebaseAuthException catch (e) {
      return ApiResponse(data: null, error: e.code);
    } catch (e) {
      return ApiResponse(data: null, error: e.toString());
    }
  }

  @override
  Future<ApiResponse> signinUser(String uid) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshots =
          await db.collection(FirebaseKeys.users).get();

      for (var element in snapshots.docs) {
        if (element.id == uid) {
          log(element.id);
          return ApiResponse(
              data: UserData.fromJson(element.data()), error: null);
        } else {
          DocumentReference userRef =
              db.collection(FirebaseKeys.users).doc(uid);

          await userRef.set(UserData(uid: uid, regStatus: 0).toJson());
          return ApiResponse(data: UserData(uid: uid), error: null);
        }
      }
      return ApiResponse(data: null, error: 'Something went wrong');
    } on FirebaseException catch (e) {
      return ApiResponse(data: null, error: e.code);
    } on Exception catch (e) {
      return ApiResponse(data: null, error: e.toString());
    }
  }
}
