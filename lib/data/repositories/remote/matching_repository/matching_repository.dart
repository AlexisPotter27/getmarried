import 'package:getmarried/data/models/api_response.dart';
import 'package:getmarried/models/user.dart';

abstract class MatchingRepository {
  Future<ApiResponse> getSuggestions(UserData user);
  Future<ApiResponse> like(String uid);
  Future<ApiResponse> disLike(String uid);
  // Future<ApiResponse> jp(String uid);
}
