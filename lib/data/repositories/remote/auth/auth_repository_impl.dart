import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:getmarried/constants/firebase_keys.dart';
import 'package:getmarried/data/models/api_response.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/presentation/screens/number.dart';

import 'auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

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
        // autoRetrievedSmsCodeForTesting: ,
        //  timeout: const Duration(seconds: 20),
        verificationCompleted: (PhoneAuthCredential credential) async {
          log('VERIFIED');
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
    debugPrint('Singining in with:${credential.smsCode}');
    try {
      UserCredential user = await auth.signInWithCredential(
        credential,
      );

      if (user.user != null) {
        debugPrint('SIGNING IN ${user.user!.phoneNumber}');

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
      debugPrint('RETREIVING USER DETAILS');

      QuerySnapshot<Map<String, dynamic>> snapshots =
          await db.collection(FirebaseKeys.users).get();

      for (var element in snapshots.docs) {
        if (element.id == uid) {
          log(element.id);
          debugPrint('USER ${element.id} ALREADY EXISTS');

          return ApiResponse(
              data: UserData.fromJson(element.data()), error: null);
        } else {
          log(element.id);
          DocumentReference userRef =
              db.collection(FirebaseKeys.users).doc(uid);
          debugPrint(' ADDING USER ${element.id}');
          await userRef.set(UserData(
            uid: uid,
          ).toJson());
          debugPrint(' USER ${element.id} ADDED');

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

  @override
  Future<ApiResponse> updateUser(UserData userData, List<File>? images) async {
    try {
      if (images != null && images.isNotEmpty) {
        ApiResponse imageUploadResponse = await uploadUserImages(images);
        if (imageUploadResponse.error != null) {
          userData.photos = imageUploadResponse.data;
        }
      }
      await db
          .collection(FirebaseKeys.users)
          .doc(userData.uid)
          .update(userData.toJson())
          .onError((error, stackTrace) => {log(error.toString())});

      return ApiResponse(data: userData, error: null);
    } on FirebaseException catch (e) {
      log(e.code.toString());
      return ApiResponse(data: null, error: e.code);
    } on Exception catch (e) {
      log(e.toString());
      return ApiResponse(data: null, error: e.toString());
    }
  }

  @override
  Future<ApiResponse> uploadUserImages(List<File>? files) async {
    List images = [];
    try {
      for (File file in files ?? []) {
        Reference imageRef =
            storage.ref(FirebaseKeys.userImages).child(DateTime.now().toIso8601String());
        UploadTask task = imageRef.putFile(file);

        images.add(await imageRef.getDownloadURL());
        // task.whenComplete(() {
        //
        // });
      }

      log(images.length.toString());
      return ApiResponse(data: images, error: null);
    } on FirebaseException catch (e) {
      return ApiResponse(data: null, error: e.code);
    } on Exception catch (e) {
      return ApiResponse(data: null, error: e.toString());
    }
  }
}
