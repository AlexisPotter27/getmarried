import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getmarried/data/models/api_response.dart';

abstract class AdminRepository {
  Future<ApiResponse> disableUser(String uid);
  Future<ApiResponse> deleteUser(String uid);
  Future<ApiResponse> unblockUser(String uid);
  Future<ApiResponse> getAllUsers();
  Future<ApiResponse> getAllReports();
  Future<ApiResponse> signinAdmin(String email, String password);
  Stream<QuerySnapshot<Map<String, dynamic>>> getUsersStream();

}