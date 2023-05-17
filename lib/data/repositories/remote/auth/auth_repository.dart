import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:getmarried/data/models/api_response.dart';
import 'package:getmarried/models/user.dart';
import 'package:image_picker/image_picker.dart';

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
  Future<ApiResponse> signInWithGoogle();
  Future<ApiResponse> signInWithAppleId();
  Future<ApiResponse> signInWithFacebook();
  Future<ApiResponse> deleteUser(String uid);


  Future<ApiResponse> updateUser(UserData userData,List<XFile>? images);

  Future<ApiResponse> uploadUserImages(List<XFile>? files);

  Future<ApiResponse> updateUserToken(String uid,);
  Stream<User?> authState();

  Stream<DocumentSnapshot<Map<String, dynamic>>> userStream(String uid);



// Future void signinWithPhoneNumber

}
