import 'package:getmarried/admin/data/models/report.dart';
import 'package:getmarried/data/models/api_response.dart';
import 'package:getmarried/models/user.dart';

abstract class MatchingRepository {
  Future<ApiResponse> getSuggestions(UserData user);
  Future<ApiResponse> like({required bool match,required String uid});
  Future<ApiResponse> disLike(String uid);
  Future<ApiResponse> reportUser(ReportModel reportModel);

// Future<ApiResponse> jp(String uid);
}
