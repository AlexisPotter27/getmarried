import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getmarried/constants/firebase_keys.dart';
import 'package:getmarried/data/models/api_response.dart';
import 'package:getmarried/data/repositories/remote/matching_repository/matching_repository.dart';
import 'package:getmarried/models/user.dart';

class MatchingRepositoryImpl extends MatchingRepository {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Future<ApiResponse> disLike(String uid) {
    // TODO: implement disLike
    throw UnimplementedError();
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
  Future<ApiResponse> like(String uid) {
    // TODO: implement like
    throw UnimplementedError();
  }

  List<UserData> suggest(UserData currentUser, List<UserData> users) {
    List<UserData> suggestions = [];

    bool conditionIsmet(UserData userData) {
      return false;
    }

    users.where(conditionIsmet);

    return [];
  }
}
