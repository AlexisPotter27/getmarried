import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:getmarried/admin/data/models/report.dart';
import 'package:getmarried/constants/firebase_keys.dart';
import 'package:getmarried/data/models/api_response.dart';
import 'package:getmarried/data/repositories/remote/matching_repository/matching_repository.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';

class MatchingRepositoryImpl extends MatchingRepository {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseFunctions firebaseFunctions = FirebaseFunctions.instance;

  @override
  Future<ApiResponse> disLike(String uid) async {
    try {
      UserData me = getIt.get<CacheCubit>().user!;
      DocumentReference swipedDocumentReference =
          db.collection(FirebaseKeys.users).doc(uid);
      final snapshot = await swipedDocumentReference.get();
      UserData swipedUserdata =
          UserData.fromJson(snapshot.data() as Map<String, dynamic>);
      log(swipedUserdata.dislikes!.length.toString());
      swipedDocumentReference
          .update({'dislikes': swipedUserdata.dislikes!..add(me.uid)});

      return ApiResponse(data: true, error: null);
    } on Exception catch (e) {
      return ApiResponse(data: {}, error: e.toString());
    }
  }

  @override
  Future<ApiResponse> getSuggestions(UserData user) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await db.collection(FirebaseKeys.users).get();
      List<UserData> users =
          snapshot.docs.map((e) => UserData.fromJson(e.data())).toList();
      List<UserData> suggestedUsers = suggest(user, users);
      return ApiResponse(data: users, error: null);
    } on FirebaseException catch (e) {
      return ApiResponse(data: null, error: e.code);
    } on Exception catch (e) {
      return ApiResponse(data: {}, error: e.toString());
    }
  }

  @override
  Future<ApiResponse> like({bool match = false, required String uid}) async {
    try {
      UserData me = getIt.get<CacheCubit>().user!;
      DocumentReference swipedDocumentReference =
          await db.collection(FirebaseKeys.users).doc(uid);

      DocumentReference userDocumentReference =
          await db.collection(FirebaseKeys.users).doc(me.uid);

      final userSnapShot = await userDocumentReference.get();
      UserData userData =
          UserData.fromJson(userSnapShot.data() as Map<String, dynamic>);

      // Retreiving the swiped users data
      final swipedUserSnapshot = await swipedDocumentReference.get();
      UserData swipedUserData =
          UserData.fromJson(swipedUserSnapshot.data() as Map<String, dynamic>);

      // Checking if user already liked the swiped user
      if (!(swipedUserData.likeMe!.contains(me.uid))) {
        swipedDocumentReference
            .update({'like_me': swipedUserData.likeMe!..add(me.uid)});
        sendLikeNotification(swipedUserData.deviceId.toString());
      }

      // Checking if user already liked the swiped user(from the logged in users list of likes)
      if (!(userData.likes!.contains(uid))) {
        log('NOT LIKED YET');
        userDocumentReference.update({'likes': userData.likes!..add(uid)});
      } else {
        log('ALREADY LIKED');
      }

      //adding the user id of both users to their list of matches
      if (match) {
        if (!swipedUserData.matches!.contains(me.uid)) {
          userDocumentReference.update({'matches': me.matches!..add(uid)});
          swipedDocumentReference
              .update({'matches': swipedUserData.matches!..add(me.uid)});
          sendMatchedNotification(
              swipedUserData.deviceId.toString(), userData.deviceId.toString());
        }
      }

      log('Completed =====>');
      // List<UserData> suggestedUsers = suggest(user, users);
      return ApiResponse(data: true, error: null);
    } on FirebaseException catch (e) {
      return ApiResponse(data: null, error: e.code);
    } on Exception catch (e) {
      log(e.toString());
      return ApiResponse(data: {}, error: e.toString());
    }
  }

  List<UserData> suggest(UserData currentUser, List<UserData> users) {
    List<UserData> suggestions = [];

    bool conditionIsmet(UserData userData) {
      // Sorting for gender
      if (userData.gender == currentUser.gender || userData.gender == null) {
        //Gender match
        return true;
      } else {
        // Gender mismatch
        return false;
      }
    }

    suggestions = users.where(conditionIsmet).toList();

    return suggestions;
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

  void sendMatchedNotification(String user1Id, String user2Id) async {
    try {
      await firebaseFunctions
          .httpsCallableFromUri(Uri.parse(
              'https://us-central1-getmarriedapp-810aa.cloudfunctions.net/callMatchedNotification'))
          .call({
        "user1": user1Id,
        "user2": user2Id,
      });
    } on FirebaseFunctionsException catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<ApiResponse> reportUser(ReportModel reportModel) async {
    try {
      await db.collection(FirebaseKeys.reports).add(reportModel.toJson());
      return ApiResponse(data: '', error: null);
    } on FirebaseException catch (e) {

      return ApiResponse(data: null, error: e.code);
    } on Exception catch (e) {
      return ApiResponse(data: null, error: e.toString());
    }
  }
}
