import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:getmarried/admin/data/models/get_reports_response.dart';
import 'package:getmarried/admin/dormain/repository/admin_repository.dart';
import 'package:getmarried/constants/firebase_keys.dart';
import 'package:getmarried/data/models/api_response.dart';
import 'package:getmarried/helper/http_helper.dart';
import 'package:getmarried/models/user.dart';

import 'package:http/http.dart' as http;

class AdminRepositoryImpl extends AdminRepository {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseFunctions firebaseFunctions = FirebaseFunctions.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Future<ApiResponse> disableUser(String uid) async {
    try {
      var result = await firebaseFunctions
          .httpsCallableFromUri(Uri.parse(
              'https://us-central1-getmarriedapp-810aa.cloudfunctions.net/callDisableUser'))
          .call({"uid": uid});

      result.data;

      log(result.data.toString());
      return ApiResponse(data: 'User blocked', error: null);
    } on FirebaseFunctionsException catch (e) {
      return ApiResponse(data: e.code, error: e.toString());
    } on Exception catch (e) {
      return ApiResponse(data: e.toString(), error: e.toString());
    }
  }

  @override
  Future<ApiResponse> getAllReports() async {
    try {
      HttpHelper httpHelper = HttpHelper();

      var response = await http.post(
          headers: {
            HttpHeaders.authorizationHeader: "...",
            "Accept": "application/json"
          },
          Uri.parse(
              'https://us-central1-getmarriedapp-810aa.cloudfunctions.net/getReports'));
      if (response.statusCode == 200) {
        log('THE RESULT ${response.body.toString()}');

        List<Report> users = List<Report>.from(
            (jsonDecode(response.body) as Map<String, dynamic>)['reports']
                .map((e) => Report.fromJson(e)));
        // response.data['reports'].map((e) => Report.fromJson(e)).toList();

        return ApiResponse(data: users, error: null);
      } else {
        return ApiResponse(data: response.body, error: response.statusCode);
      }

      // var result = await firebaseFunctions
      //     .httpsCallableFromUri(Uri.parse(
      //         'https://us-central1-getmarriedapp-810aa.cloudfunctions.net/callgetReports'))
      //     .call();
    } on FirebaseException catch (e) {
      return ApiResponse(data: null, error: e.code);
    } on Exception catch (e) {
      log(e.toString());
      return ApiResponse(data: {}, error: e.toString());
    }
  }

  @override
  Future<ApiResponse> getAllUsers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await db.collection(FirebaseKeys.users).get();
      List<UserData> users =
          snapshot.docs.map((e) => UserData.fromJson(e.data())).toList();
      return ApiResponse(data: users, error: null);
    } on FirebaseException catch (e) {
      return ApiResponse(data: null, error: e.code);
    } on Exception catch (e) {
      return ApiResponse(data: {}, error: e.toString());
    }
  }

  @override
  Future<ApiResponse> unblockUser(String uid) async {
    try {
      var result = await firebaseFunctions
          .httpsCallableFromUri(Uri.parse(
              'https://us-central1-getmarriedapp-810aa.cloudfunctions.net/callEnableUser'))
          .call({"uid": uid});

      return ApiResponse(data: 'User unblocked', error: null);
    } on FirebaseFunctionsException catch (e) {
      log(e.code);
      return ApiResponse(data: e.code, error: e.toString());
    } on Exception catch (e) {
      return ApiResponse(data: 'An error occured', error: e.toString());
    }
  }

  void sendLikeNotification(String liked) async {
    try {
      await firebaseFunctions
          .httpsCallableFromUri(Uri.parse(
              'https://us-central1-getmarriedapp-810aa.cloudfunctions.net/callLikedNotification'))
          .call({"liked": liked});
    } on FirebaseFunctionsException catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<ApiResponse> signinAdmin(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        QuerySnapshot<Map<String, dynamic>> snapshots =
            await db.collection('admin').get();

        List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = snapshots.docs
            .where((element) => element.id == userCredential.user?.uid)
            .toList();

        log(docs.length.toString());
        // log('LOGGED IN USER ${docs.first.data().toString()}');
        if (docs.isNotEmpty) {
          return ApiResponse(data: 'sucess', error: null);
        } else {
          return ApiResponse(data: null, error: 'Invalid credential');
        }
      } else {
        return ApiResponse(
            data: 'An error occured', error: 'Authentication failed');
      }
    } on FirebaseAuthException catch (e) {
      log(e.code);
      return ApiResponse(data: e.code, error: e.code);
    } on Exception catch (e) {
      return ApiResponse(data: 'An error occured', error: e.toString());
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getUsersStream() {
    return db.collection('users').snapshots();
  }

  @override
  Future<ApiResponse> deleteUser(String uid) async {
    try {
      // await auth.signOut();
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
}
