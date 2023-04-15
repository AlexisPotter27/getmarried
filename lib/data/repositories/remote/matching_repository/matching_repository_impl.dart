import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getmarried/constants/firebase_keys.dart';
import 'package:getmarried/data/models/api_response.dart';
import 'package:getmarried/data/repositories/remote/matching_repository/matching_repository.dart';
import 'package:getmarried/di/injector.dart';
import 'package:getmarried/models/user.dart';
import 'package:getmarried/presentation/blocs/cache_cubit/cache_cubit.dart';

class MatchingRepositoryImpl extends MatchingRepository {
  FirebaseFirestore db = FirebaseFirestore.instance;

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
      swipedDocumentReference.update({'dislikes': swipedUserdata.dislikes!..add(me.uid)});

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
      }

      // Checking if user already liked the swiped user(from the logged in users list of likes)
      if (!(userData.likeMe!.contains(uid))) {
        log('NOT LIKED YET');
        userDocumentReference.update({'likes': userData.likeMe!..add(uid)});
      }else{
        log('ALREADY LIKED');

      }


      //adding the user id of both users to their list of matches
      if (match) {
        //TODO : CHECK IF USERS ARE MATCHED ALREADY
        userDocumentReference.update({'matches': me.matches!..add(uid)});
        swipedDocumentReference
            .update({'matches': swipedUserData.matches!..add(me.uid)});
      }

      log('Completed =====>');
      // List<UserData> suggestedUsers = suggest(user, users);

      return ApiResponse(data: true, error: null);
    } on FirebaseException catch (e) {
      return ApiResponse(data: null, error: e.code);
    } on Exception catch (e) {
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
}