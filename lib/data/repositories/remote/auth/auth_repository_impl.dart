import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:getmarried/constants/firebase_keys.dart';
import 'package:getmarried/data/models/api_response.dart';
import 'package:getmarried/helper/app_utils.dart' as utils;
import 'package:getmarried/models/user.dart';
import 'package:getmarried/presentation/screens/number.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  final fb = FacebookAuth.instance;

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

    if (kIsWeb) {
      try {
        ConfirmationResult result = await auth
            .signInWithPhoneNumber(
              number,
              // RecaptchaVerifier(auth: )
            )
            .onError((error, stackTrace) => onVerificationFailed(
                FirebaseAuthException(code: error.toString())));
        onCodeSent(result.verificationId, 0);

        // await  result.confirm(verificationCode);

      } on Exception catch (e) {
        // TODO
      }

      // result.confirm(verificationCode)
    } else {
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
  }

  @override
  Future<ApiResponse> signinWithPhoneNumber(credential) async {
    debugPrint('Singing in with:${credential.smsCode}');
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
      debugPrint('RETRIEVING USER DETAILS');

      QuerySnapshot<Map<String, dynamic>> snapshots = await db.collection(FirebaseKeys.users).get();

      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = snapshots.docs.where((element) => element.id == uid).toList();
      log(docs.length.toString());
      // log('LOGGED IN USER ${docs.first.data().toString()}');
      if (docs.isNotEmpty) {
        return ApiResponse(data: UserData.fromJson(docs.first.data()), error: null);
      } else {
        // log(docs.first.id);
        DocumentReference userRef = db.collection(FirebaseKeys.users).doc(uid);
        // debugPrint(' ADDING USER ${docs.first.id}');
        // await userRef.set(UserData(
        //   uid: uid,
        // ).toJson());
        // debugPrint(' USER ${docs.first.id} ADDED');

        return ApiResponse(data: UserData(uid: uid), error: null);
      }

      for (var element in snapshots.docs) {
        if (element.id == uid) {
          log(element.id);
          debugPrint('USER ${element.id} ALREADY EXISTS');

          return ApiResponse(
              data: UserData.fromJson(element.data()), error: null);
        }
        log(element.id);
        DocumentReference userRef = db.collection(FirebaseKeys.users).doc(uid);
        debugPrint(' ADDING USER ${element.id}');
        await userRef.set(UserData(
          uid: uid,
        ).toJson());
        debugPrint(' USER ${element.id} ADDED');

        return ApiResponse(data: UserData(uid: uid), error: null);
      }
      return ApiResponse(data: null, error: 'Something went wrong');
    } on FirebaseException catch (e) {
      return ApiResponse(data: null, error: e.code);
    } on Exception catch (e, stack) {
      utils.showCustomToast(stack.toString());
      return ApiResponse(data: null, error: e.toString());
    }
  }

  @override
  Future<ApiResponse> updateUser(UserData userData, List<XFile>? images) async {
    if (images != null && images.isNotEmpty) {
      ApiResponse imageUploadResponse = await uploadUserImages(images);
      if (imageUploadResponse.error == null) {
        userData.photos?.addAll(imageUploadResponse.data);
      }
      log(imageUploadResponse.data.toString());
    }

    try {
      QuerySnapshot<Map<String, dynamic>> snapshots =
          await db.collection(FirebaseKeys.users).get();
      var docRef = db.collection(FirebaseKeys.users).doc(userData.uid);
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = snapshots.docs
          .where((element) => element.id == userData.uid)
          .toList();

      if (docs.isNotEmpty) {
        docRef
            .update(
              userData.toJson(),
            )
            .then((val) => {log('Finished uploading')});
      } else {
        docRef
            .set(
              userData.toJson(),
            )
            .then((val) => {log('Finished uploading')});
      }

      // WriteBatch batch = db.batch();
      // DocumentReference reference =
      //     db.collection(FirebaseKeys.users).doc(userData.uid);
      // batch.update(reference, userData.toJson());
      //
      // await batch.commit();

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
  Future<ApiResponse> uploadUserImages(List<XFile>? files) async {
    List<String> images = [];
    try {
      for (XFile file in files ?? []) {
        Reference imageRef = storage
            .ref(FirebaseKeys.userImages)
            .child(DateTime.now().toIso8601String());
        if (kIsWeb) {
          await imageRef.putData(
            await file.readAsBytes(),
            SettableMetadata(contentType: 'image/jpeg}'),
          );
        } else {
          await imageRef.putFile(File(file.path));
        }
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

  @override
  Future<ApiResponse> deleteUser(String uid) async {
    try {
      await auth.signOut();
      await db.collection(FirebaseKeys.users).doc(uid).delete();

      return ApiResponse(data: true, error: null);
    } on FirebaseException catch (e) {
      log(e.code.toString());
      return ApiResponse(data: null, error: e.code);
    } on Exception catch (e) {
      log(e.toString());
      return ApiResponse(data: null, error: e.toString());
    }
  }

  @override
  Future<ApiResponse> signInWithGoogle() async {
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(scopes: [
        'email',
        'profile',
      ]).signIn();

      // Obtain the auth details from the request
      if (googleUser != null) {
        final GoogleSignInAuthentication? googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        // Once signed in, return the UserCredential
        UserCredential userCredential =
            await auth.signInWithCredential(credential).then((value) {
          log(value.user.toString());
          return value;
        });

        return signinUser(userCredential.user!.uid);
      } else {
        log('not signed in');
        return ApiResponse(data: null, error: 'Unsuccessful');
      }
    } on FirebaseAuthException catch (e) {
      log('FIREBASE ERROR${e.message.toString()}');
      return ApiResponse(data: null, error: e.code);
    }
  }

  @override
  Future<ApiResponse> signInWithFacebook() async {
    try {
      final LoginResult res =
          await fb.login(permissions: ['email', 'public_profile']);
      // Obtain the auth details from the request
      if (res.accessToken != null) {
        return signinUser(res.accessToken!.userId);
      } else {
        log('not signed in');
        return ApiResponse(data: null, error: 'Unsuccessful');
      }
    } on FirebaseAuthException catch (e) {
      log('FIREBASE ERROR${e.message.toString()}');
      return ApiResponse(data: null, error: e.code);
    } on Exception catch (e) {
      return ApiResponse(data: null, error: e.toString());
    }

// Log in
//     final LoginResult res =
//         await fb.login(permissions: ['email', 'public_profile']);
  }

  @override
  Future<ApiResponse> signInWithAppleId() async {
    try {
      final rawNonce = generateNonce();
      final nonce = utils.sha256ofString(rawNonce);
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
        // state:,
        webAuthenticationOptions: WebAuthenticationOptions(
          // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
          clientId: 'com.getmarried',
          redirectUri:
              // For web your redirect URI needs to be the host of the "current page",
              // while for Android you will be using the API server that redirects back into your app via a deep link
              // kIsWeb
              //     ? Uri.parse('https://${window.location.host}/')
              //     :
              Uri.parse(
            'https://getmarriedapp-810aa.firebaseapp.com/__/auth/handler',
          ),
        ),
      );

      // Obtain the auth details from the request
      if (credential.identityToken != null) {
        // Create an `OAuthCredential` from the credential returned by Apple.

        final oauthCredential = OAuthProvider("apple.com").credential(
          idToken: credential.identityToken,
          rawNonce: rawNonce,
        );

        // Once signed in, return the UserCredential
        UserCredential userCredential =
            await auth.signInWithCredential(oauthCredential).then((value) {
          log(value.user.toString());
          return value;
        });

        return signinUser(userCredential.user!.uid);
      } else {
        log('not signed in');
        return ApiResponse(data: null, error: 'Unsuccessful');
      }
    } on FirebaseAuthException catch (e) {
      log('FIREBASE ERROR${e.message.toString()}');
      return ApiResponse(data: null, error: e.code);
    }
  }
}
